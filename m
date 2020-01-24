From: prabhakar.mahadev-lad.rj@bp.renesas.com (Prabhakar Mahadev Lad)
Date: Fri, 24 Jan 2020 10:12:45 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 07/10] usb: host: xhci-plat: Add
 r8a7744	support
In-Reply-To: <1579856900-21381-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1579856900-21381-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1579856900-21381-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <OSBPR01MB516071CAB831BEB6007BD8E7AA0E0@OSBPR01MB5160.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi All,

> -----Original Message-----
> From: cip-dev <cip-dev-bounces@lists.cip-project.org> On Behalf Of Lad
> Prabhakar
> Sent: 24 January 2020 09:08
> To: cip-dev at lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> Subject: [cip-dev] [PATCH 4.4.y-cip 07/10] usb: host: xhci-plat: Add r8a7744
> support
>
> This patch adds xhci r8a7744 driver support.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/usb/host/xhci-plat.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
Just a background wrt this patch as this isn't a backport from mainline kernel,  in mainline kernel for RZ/G1 the compatible string defaults to "renesas,rcar-gen2-xhci"  which isn't present in CIP, and the way xhci-plat.c in cip handles compatibility is different compared to mainline as a result this patch is added
This is patch is similar to  " usb: host: xhci-plat: Add r8a7743 support" (d09ccbb733864223402b541bdb9897cfe811881c) present in cip kernel.

Cheers,
--Prabhakar Lad

> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c index
> 8f80da4..e7f00da 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -54,7 +54,8 @@ static int xhci_plat_setup(struct usb_hcd *hcd)
>
>  if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
>      of_device_is_compatible(of_node, "renesas,xhci-r8a7791") ||
> -    of_device_is_compatible(of_node, "renesas,xhci-r8a7743")) {
> +    of_device_is_compatible(of_node, "renesas,xhci-r8a7743") ||
> +    of_device_is_compatible(of_node, "renesas,xhci-r8a7744")) {
>  ret = xhci_rcar_init_quirk(hcd);
>  if (ret)
>  return ret;
> @@ -69,7 +70,8 @@ static int xhci_plat_start(struct usb_hcd *hcd)
>
>  if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
>      of_device_is_compatible(of_node, "renesas,xhci-r8a7791") ||
> -    of_device_is_compatible(of_node, "renesas,xhci-r8a7743"))
> +    of_device_is_compatible(of_node, "renesas,xhci-r8a7743") ||
> +    of_device_is_compatible(of_node, "renesas,xhci-r8a7744"))
>  xhci_rcar_start(hcd);
>
>  return xhci_run(hcd);
> @@ -270,6 +272,7 @@ static const struct of_device_id usb_xhci_of_match[]
> = {
>  { .compatible = "marvell,armada-375-xhci"},
>  { .compatible = "marvell,armada-380-xhci"},
>  { .compatible = "renesas,xhci-r8a7743"},
> +{ .compatible = "renesas,xhci-r8a7744"},
>  { .compatible = "renesas,xhci-r8a7790"},
>  { .compatible = "renesas,xhci-r8a7791"},
>  { },
> --
> 2.7.4
>
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, 40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WEEE reg. no.: DE 14978647
