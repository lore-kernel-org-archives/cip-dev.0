From: pavel@denx.de (Pavel Machek)
Date: Sun, 20 Oct 2019 12:34:48 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 24/57] ASoC: rsnd: rsnd_mod_name()
 handles both name and ID
In-Reply-To: <1571295929-47286-25-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-25-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191020103448.GA18709@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> In the future, we will support BUSIFn, but it will be more complicated
> numbering. To avoid future confusable code, this patch modify
> rsnd_mod_name() to return understandable name.
> 
> To avoid using pointless memory, it uses static char and snprintf,
> thus, rsnd_mod_name() user should use it immediately, and shouldn't keep
> its pointer.

No, don't do that. That's a dangerous interface.

> +#define MOD_NAME_SIZE 16
> +char *rsnd_mod_name(struct rsnd_mod *mod)
> +{
> +	static char name[MOD_NAME_SIZE];
> +
> +	/*
> +	 * Let's use same char to avoid pointlessness memory
> +	 * Thus, rsnd_mod_name() should be used immediately
> +	 * Don't keep pointer
> +	 */
> +	if ((mod)->ops->id_sub) {
> +		snprintf(name, MOD_NAME_SIZE, "%s[%d%d]",
> +			 mod->ops->name,
> +			 rsnd_mod_id(mod),
> +			 rsnd_mod_id_sub(mod));
> +	} else {
> +		snprintf(name, MOD_NAME_SIZE, "%s[%d]",
> +			 mod->ops->name,
> +			 rsnd_mod_id(mod));
> +	}
> +
> +	return name;
> +}

This is too hard to use correctly.

> @@ -762,12 +759,10 @@ static int rsnd_dma_alloc(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
>  	if (ret < 0)
>  		return ret;
>  
> -	dev_dbg(dev, "%s[%d] %s[%d] -> %s[%d]\n",
> -		rsnd_mod_name(*dma_mod), rsnd_mod_id(*dma_mod),
> +	dev_dbg(dev, "%s %s -> %s\n",
> +		rsnd_mod_name(*dma_mod),
>  		rsnd_mod_name(mod_from ? mod_from : &mem),
> -		rsnd_mod_id  (mod_from ? mod_from : &mem),
> -		rsnd_mod_name(mod_to   ? mod_to   : &mem),
> -		rsnd_mod_id  (mod_to   ? mod_to   : &mem));
> +		rsnd_mod_name(mod_to   ? mod_to   : &mem));
>  
>  	ret = attach(io, dma, mod_from, mod_to);
>  	if (ret < 0)

For example this usage is not correct.

And yes, I took a look@mainline, and no, having 5 static buffers
is not really an acceptable solution.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191020/f03b5d89/attachment.sig>
