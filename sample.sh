#!/bin/bash

# sample system performance stats while a pid is running

# TODO: incorporate /proc/$pid/io read_bytes and write_bytes
# TODO: incorporate child pids

sample() {
	test -f sample.log || echo "ts cpu_usr cpu_sys mem_used rx_mb tx_mb" > sample.log
	# ts second.nanosecond
	ts=$(date +%s.%N)

	# %CPU
	read cpu_usr cpu_sys cpu_idle < <(mpstat | awk '/all/{print $4,$6,$13}')
	#echo $cpu_usr $cpu_sys $cpu_idle

	# MB of memory
	read mem_total mem_used mem_free < <(free -m | grep ^Mem: | awk '{print $2,$3,$4}')
	#echo $mem_total $mem_used $mem_free

	# bytes of Network traffic
	# iface, rx_bytes, tx bytes
	rx_sum=0
	tx_sum=0
	while read iface rx_bytes tx_bytes
	do
		#echo $iface $rx_bytes $tx_bytes
		test -f sample-$iface.log || echo "rx_bytes tx_bytes" > sample-$iface.log
		printf "%.0f %.0f\n" $rx_bytes $tx_bytes >> sample-$iface.log
		rx_sum=$(($rx_sum + $rx_bytes))
		tx_sum=$(($tx_sum + $tx_bytes))
	done < <(cat /proc/net/dev | tr -d ':|' | awk 'NR>2{print $1,$2,$10}')

	rx_sum_mb=$(($rx_sum / 1024 / 1024))
	tx_sum_mb=$(($tx_sum / 1024 / 1024))

	printf "%.3f %.1f %.1f %.0f %.0f %.0f\n" $ts $cpu_usr $cpu_sys $mem_used $rx_sum_mb $tx_sum_mb >> sample.log 
	#echo $cpu_usr $cpu_sys $cpu_idle
	#echo $mem_total $mem_used $mem_free

}

sample_pid() {
	watched_pid=$1
	sample_rate=1
	# while pid is alive, sample
	while kill -0 $watched_pid 2>/dev/null
	do
		sample
		sleep $sample_rate
	done
}

example() {
	sleep 3 & # given an existing process...
	sample_pid $! & # sample system while process runs, die when watched process does
	wait $! # wait for sample_pid to end
}

