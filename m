Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4473DC43334
	for <webhook@archiver.kernel.org>; Wed, 22 Jun 2022 15:03:53 +0000 (UTC)
Subject: Re: Reported 4.4.y-st issue from Flamefire #cip
To: cip-dev@lists.cip-project.org
From: theflamefire89@gmail.com
X-Originating-Location: Dresden, Saxony, DE (217.254.149.237)
X-Originating-Platform: Linux Firefox 101
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 22 Jun 2022 08:03:47 -0700
References: <20220622115233.GA7458@duo.ucw.cz>
In-Reply-To: <20220622115233.GA7458@duo.ucw.cz>
Message-ID: <16290.1655910227166157122@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="1rd5dOXFH7gK10p8NsR5"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jun 2022 15:03:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8583

--1rd5dOXFH7gK10p8NsR5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>=20
> Upstream said this code is correct and affected drivers should be
> fixed, instead,

First this is a practical issue: There are proprietary drivers which likely=
 will never get fixed.
And second I do not agree that this code is correct as it doesn't make sens=
e to me:

- From snd_soc_put_volsw_sx:

if (mc->platform_max && val > mc->platform_max)
	return -EINVAL;
if (val > max - min)
	return -EINVAL;
And from snd_soc_info_volsw called by snd_soc_info_volsw_sx
mc->platform_max =3D mc->max; So if platform_max gets always set to max why=
 would you compare `val` directly against platform_max but subtract min fro=
m max?

Or did upstream say that using a negative "min" is invalid? Example where t=
his is used: https://github.com/sonyxperiadev/kernel/blob/5f3e8612a373f035f=
ae72471dcbc37ec2110adde/sound/soc/codecs/wcd9335.c#L2255-L2256

I also find the following puzzling (in snd_soc_limit_volume): if (max <=3D =
mc->max) {
	mc->platform_max =3D max;

i.e. a check against "max" setting "platform_max"?

Anyway I appreciate you taking care of this and hope the above input helps =
in guiding a decision.

Best Regards,

Alex

--1rd5dOXFH7gK10p8NsR5
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<br />
<blockquote>Upstream said this code is correct and affected drivers should =
be<br />fixed, instead,</blockquote>
<p>First this is a practical issue: There are proprietary drivers which lik=
ely will never get fixed.<br />And second I do not agree that this code is =
correct as it doesn't make sense to me:<br /><br />- From snd_soc_put_volsw=
_sx:</p>
<pre><code>if (mc-&gt;platform_max &amp;&amp; val &gt; mc-&gt;platform_max)
	return -EINVAL;
if (val &gt; max - min)
	return -EINVAL;
</code></pre>
And from snd_soc_info_volsw called by snd_soc_info_volsw_sx<br />
<pre><code>mc-&gt;platform_max =3D mc-&gt;max;</code></pre>
So if platform_max gets always set to max why would you compare `val` direc=
tly against platform_max but subtract min from max?<br /><br />Or did upstr=
eam say that using a negative "min" is invalid? Example where this is used:=
 https://github.com/sonyxperiadev/kernel/blob/5f3e8612a373f035fae72471dcbc3=
7ec2110adde/sound/soc/codecs/wcd9335.c#L2255-L2256<br /><br />I also find t=
he following puzzling (in snd_soc_limit_volume):
<pre><code>if (max &lt;=3D mc-&gt;max) {
	mc-&gt;platform_max =3D max;
</code></pre>
<p>i.e. a check against "max" setting "platform_max"?<br /><br />Anyway I a=
ppreciate you taking care of this and hope the above input helps in guiding=
 a decision.<br /><br />Best Regards,</p>
<p>Alex</p>

--1rd5dOXFH7gK10p8NsR5--

