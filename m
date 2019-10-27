From: pavel@denx.de (Pavel Machek)
Date: Sun, 27 Oct 2019 08:51:10 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 50/57] ASoC: rsnd: fixup 6ch
	settings to 8ch
In-Reply-To: <1571295929-47286-51-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-51-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191027075110.GD28383@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu 2019-10-17 08:05:22, Biju Das wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> commit 66287def435315d9d8de740da4c543e37630b897 upstream.
> 
> rsnd need to use 8ch clock settings for 6ch for TDM.
> Otherwise, it can't work correctly.
> This patch fixup it.

Ok, but...

> +int rsnd_channel_normalization(int chan)
> +{
> +	if ((chan > 8) || (chan < 0))
> +		return 0;
> +
> +	/* TDM Extend Mode needs 8ch */
> +	if (chan == 6)
> +		chan = 8;
> +
> +	return chan;
> +}
> +

Should the if ((chan > 8) || (chan < 0)) ever be true in practice?
Sounds like bogus inputs to me. Should we dev_err() and return error
in those cases? Or@least WARN_ON()?

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191027/26df021d/attachment.sig>
