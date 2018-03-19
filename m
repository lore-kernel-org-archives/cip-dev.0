From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Mon, 19 Mar 2018 09:21:32 +0100
Subject: [cip-dev] [ANNOUNCE] 4.4.120-cip20-rt13
In-Reply-To: <CAEss1EL7HpNBB+ywuZjgXgjYSJYRG_6C8CSnYdKOHcMDpUSzOA@mail.gmail.com>
References: <20180309144337.7FEBD500C74@mail.monom.org>
	<CAEss1ELR0=AJEacFu0sF-9=wkuqmePSYKrV_KQdochKZVaxpyw@mail.gmail.com>
	<766d9022-b640-fdb0-0599-c5e5f64db58c@monom.org>
	<CAEss1EL7HpNBB+ywuZjgXgjYSJYRG_6C8CSnYdKOHcMDpUSzOA@mail.gmail.com>
Message-ID: <70077ab3-5dd1-09a2-06ae-0de36420645d@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Zoran,

On 03/16/2018 03:57 PM, Zoran S wrote:
> Hello Daniel,
> 
> I did tests as advised by you on BBB01. Unfortunately, I am (for now)
> not able to do this on iwg20m, will be interesting to compare these two
> platforms.
> 
> Sort of, to make more clear what the tests are, the following is short
> clarification:
> 
> [1] while true; do hackbench ; done
> 
> user at host: ~ $ hackbench Running in process mode with 10 groups using 40
> file descriptors each (== 400 tasks)
> Each sender will pass 100 messages of 100 bytes
> Average time on my test for BBB01 is around 5.70
> 
> This default gives (on the long run) on BBB01 HW the average load around
> 300! I could not believe my eyes, still BBB01 withstood such a
> torturing! :-)

hackbench is stressing the scheduler by creating a high number of
threads which send messages to each other. If hackbench crashes the bbb
that would be rather bad. So this is expected behavior and nothing to
worry about. If you want to keep the system a bit more responsive you
can limit the number of threads, e.g.

while true; do hackbench 40 ; done

You can also create additional load with various other tools. A very
common stress load is building a kernel on the system. Though that needs
a lot of setup to get going. Maybe have a look at stress-ng or cpuburn?

> [2] cyclictest -p 80 -n -m -S
> https://events.static.linuxfound.org/sites/events/files/slides/cyclictest.pdf
> <https://events.static.linuxfound.org/sites/events/files/slides/cyclictest.pdf>
> 
> This .pdf explains all in details.

The next logic step to do is to create a histogram by cyclictest and
parse the result in lava. Maybe even render the plot. Mabye this has
been already done upstream. So better check first if someone has done
this already.
 _______
> 
> Now, I made one unsuccessful attempt to create the correct .config,
> where the following happened:
> 
> CONFIG_SUSPEND=y
> CONFIG_HIBERNATION=y
> CONFIG_PM=y
> CONFIG_PREEMPT_RT_FULL=n

kconfig has some dependency checking/updating code. So even when you set
a config option to a value, it might be overwritten again by a
dependency. Don't worry about this to much. I spend a lot of time
figuring out how to do it. I can also generate a complete config for bbb
which has the above set. Again, not terrible important right now.

> Here are results from such a configuration, after approximately 60
> minutes of running:
> ?
> root at beaglebone:~# cyclictest -p 80 -n -m -S
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 279.21 300.75 315.83 387/480 30402?????????
> 
> T: 0 ( 8880) P:80 I:1000 C:3453637 Min:???? 15 Act:?? 49 Avg:?? 51
> _/*Max:? */__/*1386*/_

The max value is likely due to the config settings.

> Then I again have created the whole .config file again, deleting all the
> previous build, and this time this was a correct .config.
> 
> Please, find it attached to this email (the full .config version) as
> CONFIG (since some other people might want to try such BBB01 RT tests).
> 
> And here are results from the run, which lasted around ~50 minutes (~3
> million cycles):
> root at beaglebone:~# uname -a
> Linux beaglebone 4.4.120-cip20-rt13-dirty #1 PREEMPT RT Fri Mar 16
> 13:41:18 GMT 2018 armv7l GNU/Linux
> 
> root at beaglebone:~# cyclictest -p 80 -n -m -S
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 203.66 71.89 25.88 159/504 8144?????????
> policy: fifo: loadavg: 282.71 297.38 290.00 196/504 10767?????????
> T: 0 ( 7343) P:80 I:1000 C:?? 9151 Min:???? 19 Act:?? 44 Avg:?? 42
> Max:????? 68
> _/*T: 0 ( 7343) P:80 I:1000 C:3129069 Min:????? 8 Act:?? 31 Avg:?? 42
> Max:????? 81*/_
> 
> /*Excellent job done on 4.4.120-cip20-rt13! Hats Down!*/

Indeed these numbers look reasonable good and are the ballpark I would
expect.

Thanks,
Daniel
