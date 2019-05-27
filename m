From: nobuhiro1.iwamatsu@toshiba.co.jp (Nobuhiro Iwamatsu)
Date: Mon, 27 May 2019 09:27:28 +0900
Subject: [cip-dev] [PATCH 4.4.y 0/2] Add SMP support to the RZ/G1C
In-Reply-To: <1558694614-14062-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1558694614-14062-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20190527002728.ydsehe4pt6be6hte@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Fabrizio,

On Fri, May 24, 2019 at 11:43:32AM +0100, Fabrizio Castro wrote:
> Dear All,
> 
> this series adds SMP support to the RZ/G1C SoC (a.k.a r8a77470)
> specific dtsi.
> 
> Thanks,
> Fab
> 
> Fabrizio Castro (2):
>   dt-bindings: apmu: Document r8a77470 support
>   ARM: dts: r8a77470: Add SMP support
> 
>  Documentation/devicetree/bindings/power/renesas,apmu.txt |  1 +
>  arch/arm/boot/dts/r8a77470.dtsi                          | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
> 

Both patches looks good to me.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro
