From: pavel@denx.de (Pavel Machek)
Date: Sun, 27 Oct 2019 08:56:18 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 52/57] ASoC: rsnd: fixup mod ID
 calculation in rsnd_ctu_probe_
In-Reply-To: <1571295929-47286-53-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-53-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191027075618.GE28383@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu 2019-10-17 08:05:24, Biju Das wrote:
> From: Nilkanth Ahirrao <anilkanth@jp.adit-jv.com>
> 
> commit ac28ec07ae1c5c1e18ed6855eb105a328418da88 upstream.
> 
> commit c16015f36cc1 ("ASoC: rsnd: add .get_id/.get_id_sub")
> introduces rsnd_ctu_id which calcualates and gives
> the main Device id of the CTU by dividing the id by 4.
> rsnd_mod_id uses this interface to get the CTU main
> Device id. But this commit forgets to revert the main
> Device id calcution previously done in rsnd_ctu_probe_
> which also divides the id by 4. This path corrects the
> same to get the correct main Device id.
> 
> The issue is observered when rsnd_ctu_probe_ is done for CTU1
> 
> Fixes: c16015f36cc1 ("ASoC: rsnd: add .get_id/.get_id_sub")

> @@ -108,7 +108,7 @@ static int rsnd_ctu_probe_(struct rsnd_mod *mod,
>  			   struct rsnd_dai_stream *io,
>  			   struct rsnd_priv *priv)
>  {
> -	return rsnd_cmd_attach(io, rsnd_mod_id(mod) / 4);
> +	return rsnd_cmd_attach(io, rsnd_mod_id(mod));
>  }
>  
>  static void rsnd_ctu_value_init(struct rsnd_dai_stream *io,

Ok, but again, could it be next to the patch it fixes?

Thanks,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191027/66bfdef2/attachment.sig>
