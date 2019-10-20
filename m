From: pavel@denx.de (Pavel Machek)
Date: Sun, 20 Oct 2019 12:54:09 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 32/57] ASoC: rsnd: use ring buffer
 for rsnd_mod_name()
In-Reply-To: <1571295929-47286-33-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-33-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191020105409.GE18709@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu 2019-10-17 08:05:04, Biju Das wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> commit 0246c661b6f0051ef7bfbfff01d8ef7fd0359372 upstream.
> 
> commit c0ea089dbad4 ("ASoC: rsnd: rsnd_mod_name() handles both name and
> ID") merged "name" and "ID" on rsnd_mod_name() to handle sub-ID
> (= for CTU/BUSIF).
> Then, it decided to share static char to avoid pointless memory.
> But, it doesn't work correctry in below case, because last called
> name will be used.
> 
> 	dev_xxx(dev, "%s is connected to %s\n",
> 		rsnd_mod_name(mod_a),  /* ssiu[00] */
> 		rsnd_mod_name(mod_b)); /* ssi[0]   */
> 	->
> 	rcar_sound ec500000.sound: ssi[0] is connected to ssi[0]
> 	                           ~~~~~~                 ~~~~~~
> We still don't want to have pointless memory, so let's use ring buffer.
> 16byte x 5 is very enough for this purpose.
> 
> 	dev_xxx(dev, "%s is connected to %s\n",
> 		rsnd_mod_name(mod_a),  /* ssiu[00] */
> 		rsnd_mod_name(mod_b)); /* ssi[0]   */
> 	->
> 	rcar_sound ec500000.sound: ssiu[00] is connected to ssi[0]
> 	                           ~~~~~~~~                 ~~~~~~

I'd really preffer caller passing pointer to buffer to be used to the
function.

Best regards,
								Pavel

> +++ b/sound/soc/sh/rcar/core.c
> @@ -137,10 +137,17 @@ struct dma_chan *rsnd_mod_dma_req(struct rsnd_dai_stream *io,
>  	return mod->ops->dma_req(io, mod);
>  }
>  
> +#define MOD_NAME_NUM   5
>  #define MOD_NAME_SIZE 16
>  char *rsnd_mod_name(struct rsnd_mod *mod)
>  {
> -	static char name[MOD_NAME_SIZE];
> +	static char names[MOD_NAME_NUM][MOD_NAME_SIZE];
> +	static int num;
> +	char *name = names[num];
> +
> +	num++;
> +	if (num >= MOD_NAME_NUM)
> +		num = 0;
>  
>  	/*
>  	 * Let's use same char to avoid pointlessness memory

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191020/cd2652f6/attachment.sig>
