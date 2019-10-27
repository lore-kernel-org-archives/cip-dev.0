From: pavel@denx.de (Pavel Machek)
Date: Sun, 27 Oct 2019 08:33:13 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 40/57] ASoC: rsnd: update
	BSDSR/BSDISR handling
In-Reply-To: <1571295929-47286-41-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-41-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191027073313.GA28383@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> Current BSDSR/BSDISR are using temporary/generic settings, but it can't
> handle all SRCx/SoC. It needs to handle correctry.
> Otherwise, sampling rate converted sound channel will be broken if it
> was TDM. One note is that it needs to overwrite settings on E3 case.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

>  static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
>  				      struct rsnd_mod *mod)
>  {
...
> +	if (chan > 8 ||
> +	    idx >= ARRAY_SIZE(chan222222))
> +		goto convert_rate_err;
...
> @@ -244,6 +344,11 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
>  	rsnd_mod_write(mod, SRC_BUSIF_DALIGN, rsnd_get_dalign(mod, io));
>  
>  	rsnd_adg_set_src_timesel_gen2(mod, io, fin, fout);
> +
> +	return;
> +
> +convert_rate_err:
> +	dev_err(dev, "unknown BSDSR/BSDIR settings\n");
>  }

If error happens, would it make sense to propagate it back to the
caller?

Best regards,
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191027/8581ba07/attachment.sig>
