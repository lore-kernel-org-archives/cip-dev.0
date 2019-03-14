From: patryk.mungai-ndungu.kx@renesas.com (Patryk Mungai Ndungu)
Date: Thu, 14 Mar 2019 16:40:59 +0000
Subject: [cip-dev] Testing update + cip-core
Message-ID: <OSBPR01MB2055F3150CC418B4FFA7A740E94B0@OSBPR01MB2055.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Daniel,

Thanks again for adding lsusb to cip-core.

I managed to add internet support to the boards in our LAVA lab the other day. Now that this is the case, it would be really useful to have apt-get installed in cip-core, in case any dependencies are missing in the rfs. 

To run any tests that require a download from the internet, you need to run the following script first (it'll be added to the main repo soon): https://gitlab.com/mungaip/cip-kernel-tests/blob/dut-internet-support/setup_internet.yaml. Let me know if any of this could/should be done in cip-core too.

Example test definition: https://lava.ciplatform.org/scheduler/job/718/definition  

Kind Regards,
Patryk
