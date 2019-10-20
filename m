From: pavel@denx.de (Pavel Machek)
Date: Sun, 20 Oct 2019 11:49:24 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 19/57] ASoC: rsnd: use 32bit TDM
 width as default
In-Reply-To: <1571295929-47286-20-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-20-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191020094924.GG8003@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu 2019-10-17 08:04:51, Biju Das wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> commit 82ab7e9a4d3fcec27f745be04063e17da1881dda upstream.
> 
> commit fb2815f44a9e ("ASoC: rsnd: add support for 16/24 bit slot widths")
> added TDM width check, and return error if it was not 16/24/32 bit.
> But it is too strict. This patch uses 32bit same as default.

> @@ -738,8 +738,8 @@ static int rsnd_soc_set_dai_tdm_slot(struct snd_soc_dai *dai,
>  	case 32:
>  		break;
>  	default:
> -		dev_err(dev, "unsupported slot width value: %d\n", slot_width);
> -		return -EINVAL;
> +		/* use default */
> +		slot_width = 32;
>  	}
>  
>  	switch (slots) {

I don't think I like this. People should not be passing strange values
to this function. Can the caller be fixed, instead?

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191020/7f233998/attachment-0001.sig>
