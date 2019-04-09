From: pavel@denx.de (Pavel Machek)
Date: Tue, 9 Apr 2019 23:03:54 +0200
Subject: [cip-dev] [PATCH 4.19y 01/10] pinctrl: sh-pfc: r8a77990: Add
 CAN pins, groups and functions
In-Reply-To: <1554126947-32747-2-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1554126947-32747-2-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20190409210354.GF3845141@pollux.denx.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon 2019-04-01 14:55:38, Fabrizio Castro wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> commit c1e5bd286fe501992165608551f889ec69f5901a upstream.
> 
> This patch adds CAN{0,1} pins, groups and functions to the R8A77990 SoC.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

This does not apply. My kernel still has:

> -     struct sh_pfc_pin_group common[117];

while this expects... way higher number. I tried to look at pending patches
in patchwork, that maybe if I tried to apply everything it would work, but
could not get that to work, either.

Current status of the tree is at:

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip

Could the patches that depend on each other go into one series? If it is
hard identifying what depends on what, maybe the best way forward is to 
create a big series on top of 64729dc0be4847961550cdcca4ddc66adf556aaa
with all patches you have pending. Your patches seem to be in good shape,
so applying it should not be a big deal.

Thanks and sorry for confusion,
								Pavel

> @@ -3475,7 +3504,7 @@ static const unsigned int vin5_clk_b_mux[] = {
>  };
>  
>  static const struct {
> -	struct sh_pfc_pin_group common[238];
> +	struct sh_pfc_pin_group common[241];
>  	struct sh_pfc_pin_group automotive[0];
>  } pinmux_groups = {
>  	.common = {
> @@ -3504,6 +3533,9 @@ static const struct {



-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
