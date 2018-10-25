From: nobuhiro.iwamatsu@miraclelinux.com (Nobuhiro Iwamatsu)
Date: Thu, 25 Oct 2018 15:43:46 +0900
Subject: [cip-dev] [PATCH 0/2] Add PMU support to iwg2[02]m
In-Reply-To: <1540305035-22457-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
References: <1540305035-22457-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
Message-ID: <CAGDrK-ZgvA3vyw4X4rQStfvm47iU0+qJtu72U7RU=srnSMcQ6g@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi, Patryk.

2018?10?23?(?) 23:30 Patryk Mungai <patryk.mungai-ndungu.kx@renesas.com>:
>
> Backport PMU support for iwg2[02]m to the CIP Kernel from mainline.
>
> Removed [Backported to CIP] from original patches
>
> Geert Uytterhoeven (2):
>   ARM: dts: r8a7745: Add PMU device node
>   ARM: dts: r8a7743: Add PMU device node
>
>  arch/arm/boot/dts/r8a7743.dtsi | 7 +++++++
>  arch/arm/boot/dts/r8a7745.dtsi | 7 +++++++
>  2 files changed, 14 insertions(+)
>

Applied to linux-4.4.y-cip, thanks.

Best regards,
  Nobuhiro
