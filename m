From: nobuhiro.iwamatsu@miraclelinux.com (Nobuhiro Iwamatsu)
Date: Wed, 27 Mar 2019 07:06:48 +0900
Subject: [cip-dev] Arm64 configs
In-Reply-To: <TYAPR01MB2285078E1883115EAF97B917B7410@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2285078E1883115EAF97B917B7410@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <CAGDrK-YWk_6pkW6d+BLfAC3DAK3W4P5VLs5v=ArsQtf7kuGvFg@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi, Chris.

Sorry for my late reply.

2019?3?20?(?) 22:37 Chris Paterson <Chris.Paterson2@renesas.com>:
>
> Hello maintainers, all,
>
>
>
> As discussed previously we need to decide what Kernel configs to use/support for the arm64 architecture.
>
>
>
> Arm64 only has one supported config upstream ? ?defconfig? [1]. This is huge and presumably something CIP doesn?t want to support in its entirety in the linux-4.19.y-cip for the next 10 years.
>
>

Indeed.

>
> The alternative is for CIP create our own cut down defconfig(s) that meet the requirements of our users/members.
>
>
>
> From a Renesas point of view there is an out-of-tree renesas-defconfig [2] which our upstream team uses to aid their development on Renesas arm64 platforms. Perhaps we could either add this to the CIP tree, or to the CIP Kernel configs repository [3] as a starting point?
>
>

I agree. However, if renesas-defconfig includes configs not for RZ
(eg. R-Car), we may be better to delete them.
Could you send a patch of renesas-defconfig?

>
>
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/arch/arm64/configs/defconfig?h=linux-4.19.y-cip
>
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git/tree/arch/arm64/configs/renesas_defconfig?h=devel
>
> [3] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config
>
>
>
> Kind regards, Chris
>

Best regards,
  Nobuhiro

> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
