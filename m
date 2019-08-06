From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 6 Aug 2019 10:45:54 +0000
Subject: [cip-dev] powerpc support on CIP kernel v4.4 not required
	anymore
In-Reply-To: <OSBPR01MB3077C8219AC5A0297B18E0C1D0D50@OSBPR01MB3077.jpnprd01.prod.outlook.com>
References: <OSBPR01MB3077C8219AC5A0297B18E0C1D0D50@OSBPR01MB3077.jpnprd01.prod.outlook.com>
Message-ID: <TYAPR01MB22857EBA3710C0B32EC30E43B7D50@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Daniel,

> From: daniel.sangorrin at toshiba.co.jp <daniel.sangorrin@toshiba.co.jp>
> Sent: 06 August 2019 07:38
> 
> Hi all,
> 
> After an internal survey, it seems that Toshiba doesn't need support for our
> 4.4 PowerPC defconfig anymore.
> 
> Hopefully, this will also release some time for kernel review and kernel
> testing.

Thank you for the heads up. I'll probably still add powerpc build support [1] to linux-cip-ci just in case you need it.
I just won't add the toshiba_defconfig to the list of configs routinely tested.

I'll merge [1] on the assumption that you don't mind me setting "CONFIG_PPC_DISABLE_WERROR=y" [2].


[1] https://gitlab.com/cip-project/cip-testing/linux-cip-ci/merge_requests/9
[2] https://gitlab.com/cip-project/cip-testing/linux-cip-ci/merge_requests/9/diffs?commit_id=34b2148dd316e7ba0ff375d870bd0055eac413d1#2f8b0f779f61a9c72c895c7f9a5fc21a71497b98_77_79


Kind regards, Chris

> 
> Thanks,
> Daniel
