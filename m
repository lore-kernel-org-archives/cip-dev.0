From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Tue, 19 Mar 2019 03:00:45 +0000
Subject: [cip-dev] Testing update + cip-core
In-Reply-To: <OSBPR01MB2055F3150CC418B4FFA7A740E94B0@OSBPR01MB2055.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2055F3150CC418B4FFA7A740E94B0@OSBPR01MB2055.jpnprd01.prod.outlook.com>
Message-ID: <OSAPR01MB376303BDABB64E54B07645C2D0400@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Patryk,

Sorry for the late reply.

> -----Original Message-----
> From: Patryk Mungai Ndungu <patryk.mungai-ndungu.kx@renesas.com>
> Sent: Friday, March 15, 2019 1:41 AM
> To: sangorrin daniel(????? ???? ????????) <daniel.sangorrin@toshiba.co.jp>
> Cc: cip-dev at lists.cip-project.org
> Subject: Testing update + cip-core
> 
> Hello Daniel,
> 
> Thanks again for adding lsusb to cip-core.
> 
> I managed to add internet support to the boards in our LAVA lab the other day. Now that this is the case, it would
> be really useful to have apt-get installed in cip-core, in case any dependencies are missing in the rfs.

I will send the AWS instructions to Jan and create an account for him so that he can upload ISAR images.
We will need to port ISAR to the Renesas board though.

> To run any tests that require a download from the internet, you need to run the following script first (it'll be added
> to the main repo soon):
> https://gitlab.com/mungaip/cip-kernel-tests/blob/dut-internet-support/setup_internet.yaml. Let me know if
> any of this could/should be done in cip-core too.

https://gitlab.com/cip-project/cip-testing/cip-kernel-tests/blob/master/test_cases/setup_internet.yaml

I think that route and wget are included in cip-core.

It seems to work fine:
https://lava.ciplatform.org/scheduler/job/828

Thanks,
Daniel

> 
> Example test definition: https://lava.ciplatform.org/scheduler/job/718/definition
> 
> Kind Regards,
> Patryk
> 
