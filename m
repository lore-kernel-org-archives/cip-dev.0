From: wagi@monom.org (Daniel Wagner)
Date: Thu, 16 Jan 2020 18:13:52 +0100
Subject: [cip-dev] RT Testing
In-Reply-To: <20200116132526.GA14898@duo.ucw.cz>
References: <TYAPR01MB2285FB4BDC74EB669E362E89B7340@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20200116132526.GA14898@duo.ucw.cz>
Message-ID: <20200116171352.x5jmhwqzkzi2s5sj@beryllium.lan>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, Jan 16, 2020 at 02:25:27PM +0100, Pavel Machek wrote:
> Even basic cyclictest is good to have, but it would be really good to
> have some kind of background load. I'd expect latency to raise by
> factor of 3 in make -j 5 of kernel.

I've been experimenting with compiling the kernel as workload to
trigger latency spikes. So far this test didn't trigger one. It is
quite good to see if there are performance rgressions (it takes
suddenly longer). As long there is enough space on the device and all
tools are available it's okay to run it.

I found it a bit difficult to use it in lava because the rootfs
doesn't bring all the tools and the kernel source it takes ages to
setup.

> I tried to come up with simpler test reproducing comparable latencies,
> but I did not get there. This creates cca factor of two for me:
>
> cat /dev/urandom | head -c 10000000 | gzip -9 - > delme.random.gz
> echo "Initial phase done"
> for A in `seq 222`; do
>     ( zcat delme.random.gz | gzip -9 - | zcat > /dev/null; echo -n [$A done] ) &
> done
>
> What is easily available on the test systems? gzip? python? bzip2?

I am using rt-tests and plan to run more stressors from
stress-ng. This seems to give a good reproducable workload and really
stresses the system.

Thanks,
Daniel
