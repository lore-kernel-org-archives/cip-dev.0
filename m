Return-Path: <SRS0=Wox9=5W=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E97DC2BA2B
	for <cip-dev@archiver.kernel.org>; Mon,  6 Apr 2020 19:34:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0746206F5
	for <cip-dev@archiver.kernel.org>; Mon,  6 Apr 2020 19:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KfDvY6rI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0746206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9517421577;
	Mon,  6 Apr 2020 19:34:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FGGZkCe+9lS0; Mon,  6 Apr 2020 19:34:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7178F204F8;
	Mon,  6 Apr 2020 19:34:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4659EC0177;
	Mon,  6 Apr 2020 19:34:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 459AFC0177
 for <cip-dev@lists.cip-project.org>; Mon,  6 Apr 2020 19:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4274F87857
 for <cip-dev@lists.cip-project.org>; Mon,  6 Apr 2020 19:34:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u1kWEYDJyaHQ for <cip-dev@lists.cip-project.org>;
 Mon,  6 Apr 2020 19:34:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com
 [209.85.166.47])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F406E878D8
 for <cip-dev@lists.cip-project.org>; Mon,  6 Apr 2020 19:34:43 +0000 (UTC)
Received: by mail-io1-f47.google.com with SMTP id o127so793394iof.0
 for <cip-dev@lists.cip-project.org>; Mon, 06 Apr 2020 12:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=FM9zIigRr0yLOoTZ80MvjYnoM4SwovkIjSKE6lua/U0=;
 b=KfDvY6rI0dFZEwy0PkNu7czfOaDDygpk+R+yUBFRoWqwqMlNfNBTTe8tL7izPZZ5Ab
 LoCybmblfDd/IiJ+4zs5dBo+VhJVTPkaP9ZcMMu29k13epKoWFEQ4yRdzPeGcp5uAKkH
 KbZcaVICy7ljLXBwhxAvp5TD8DWy7OEK/nz00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=FM9zIigRr0yLOoTZ80MvjYnoM4SwovkIjSKE6lua/U0=;
 b=twmvUwTREQXbNifw2IXe2o3P4C2/T+4SOdNs0h/1lsxvFutCWdxgcRwwYvCedo6R7u
 VBbIF+w00hdCShy52Zfj6754uxS6cYjkocyiYFiQxvm6+s2iwMZDJg+nMarEy46ry/mF
 jdmjOMW7CUU+5BvjGGP70zNsQHCt1qny7c6EjPeeIg9rSjE0nXoLg68EyPHHR9I4vzBz
 Jg0c8HbibY+jr9nhHjlDB7dnforiZ55ITtE3BheqnTyclLtfl+3oB0T9W0C2q7DeGs2Y
 GDLdB9+cdIzMByHv+00KfHhxiOr6jIbktnE+wNbWUKEwng4sEQc0pSByKRnFkvi4+mEQ
 c3SQ==
X-Gm-Message-State: AGi0PuYd89dl1GAAPoJ6wNdW8ZmbhY5r0tqRfNt8mP0Zai66g+Ye71AF
 jM0ABqKkLZ9fhxjEs+ae0HDpugcQBmwomHxy/ac2yg==
X-Google-Smtp-Source: APiQypLSbxrlT2PjM1tWSekt6DHZhexfuCEfY/x1kRYYlGQBkmzASTMNbpJN6h93kj3WhYje83z+hCCAgCNISfoAed8=
X-Received: by 2002:a6b:d20f:: with SMTP id q15mr21772456iob.179.1586201683036; 
 Mon, 06 Apr 2020 12:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAODMxsK_vgo-=FikL1Z2iYXtetRh+KpRJNL4MchmfXvLMqBTUA@mail.gmail.com>
In-Reply-To: <CAODMxsK_vgo-=FikL1Z2iYXtetRh+KpRJNL4MchmfXvLMqBTUA@mail.gmail.com>
From: Neal Caidin <ncaidin@linuxfoundation.org>
Date: Mon, 6 Apr 2020 15:34:26 -0400
Message-ID: <CAODMxsJ5anJK+heh9rnWtAsvCCFLhVnm40cffABgG686_312mQ@mail.gmail.com>
To: cip-board@lists.cip-project.org, cip-members@lists.cip-project.org, 
 cip-security@lists.cip-project.org, cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Mailman2 to Groups.io reminder
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4558935948119215960=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

--===============4558935948119215960==
Content-Type: multipart/alternative; boundary="000000000000dc9e2a05a2a45bc3"

--000000000000dc9e2a05a2a45bc3
Content-Type: text/plain; charset="UTF-8"

Reminder.  Mailman2 to Groups.io conversion about to kick off (about an 1
1/2 hours from now).


Please see schedule below.

Best Regards,
Neal



*Neal Caidin*
Program Manager, Program Management & Operations
The Linux Foundation
+1 (919) 238-9104 (w/h)
+1 (919) 949-1861 (m)
ncaidin@linuxfoundation.org


On Thu, Apr 2, 2020 at 4:56 PM Neal Caidin <ncaidin@linuxfoundation.org>
wrote:

> [cross posted]
>
> Reminder.  Mailman2 to Groups.io email is scheduled to start on
>
> Pacific - 2 pm , Monday, April 6
> Eastern - 5 pm, Monday April 6
> CET - 11 pm, Monday April 6
> JST - 6 am, Tuesday, April 7
>
> It is expected to take several hours, but could be as much as a full 24
> hours.
>
> When the migration is completed, I will send out the links so that you can
> access email archives.
>
> Best regards,
> Neal
>
>
> *Neal Caidin*
> Program Manager, Program Management & Operations
> The Linux Foundation
> +1 (919) 238-9104 (w/h)
> +1 (919) 949-1861 (m)
> ncaidin@linuxfoundation.org
>

--000000000000dc9e2a05a2a45bc3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Reminder.=C2=A0 Mailman2 to Groups.io con=
version about to kick off (about an 1 1/2 hours=C2=A0from now).</div><div d=
ir=3D"ltr"><br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">Please see=
 schedule below.</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">Best Rega=
rds,</div><div>Neal</div><div><br></div><div dir=3D"ltr"><div><br></div><di=
v><br clear=3D"all"><div><div dir=3D"ltr" data-smartmail=3D"gmail_signature=
"><div dir=3D"ltr"><div><div dir=3D"ltr"><span><font color=3D"#888888"><div=
 dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><=
div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><b style=3D"color:rgb(136=
,136,136)"><font color=3D"#666666"><font color=3D"#888888">Neal Caidin</fon=
t></font></b><br><div style=3D"color:rgb(136,136,136)"><span style=3D"borde=
r-collapse:collapse"><div><font color=3D"#666666"><font>Program Manager, Pr=
ogram Management &amp; Operations</font></font></div><div><font color=3D"#6=
66666"><font>The Linux Foundation</font></font></div><div><font color=3D"#6=
66666">+1 (919) 238-9104 (w/h)<br>+1 (919) 949-1861 (m)</font></div><div><f=
ont color=3D"#666666"><a href=3D"mailto:ncaidin@linuxfoundation.org" target=
=3D"_blank">ncaidin@linuxfoundation.org</a></font></div></span></div></div>=
</div></div></div></div></div></div></div></div></font></span></div></div><=
/div></div></div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Thu, Apr 2, 2020 at 4:56 PM Neal Caidin &lt;<=
a href=3D"mailto:ncaidin@linuxfoundation.org" target=3D"_blank">ncaidin@lin=
uxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><div dir=3D"ltr">[cross posted]<div><br></div><div>Reminder=
.=C2=A0 Mailman2 to Groups.io email is scheduled to start on=C2=A0</div><di=
v><br></div><div>Pacific - 2 pm , Monday, April 6</div><div>Eastern - 5 pm,=
 Monday April 6</div><div>CET - 11 pm, Monday April 6</div><div>JST - 6 am,=
 Tuesday, April 7</div><div><br></div><div>It is expected to take several h=
ours, but could be as much as a full 24 hours.=C2=A0</div><div><br></div><d=
iv>When the migration is completed, I will send out the links so that you c=
an access email archives.</div><div><br></div><div>Best regards,</div><div>=
Neal</div><div><br></div><div><br clear=3D"all"><div><div dir=3D"ltr"><div =
dir=3D"ltr"><div><div dir=3D"ltr"><span><font color=3D"#888888"><div dir=3D=
"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><b style=3D"color:rgb(136,136,13=
6)"><font color=3D"#666666"><font color=3D"#888888">Neal Caidin</font></fon=
t></b><br><div style=3D"color:rgb(136,136,136)"><span style=3D"border-colla=
pse:collapse"><div><font color=3D"#666666"><font>Program Manager, Program M=
anagement &amp; Operations</font></font></div><div><font color=3D"#666666">=
<font>The Linux Foundation</font></font></div><div><font color=3D"#666666">=
+1 (919) 238-9104 (w/h)<br>+1 (919) 949-1861 (m)</font></div><div><font col=
or=3D"#666666"><a href=3D"mailto:ncaidin@linuxfoundation.org" target=3D"_bl=
ank">ncaidin@linuxfoundation.org</a></font></div></span></div></div></div><=
/div></div></div></div></div></div></div></font></span></div></div></div></=
div></div></div></div>
</blockquote></div>
</div>

--000000000000dc9e2a05a2a45bc3--

--===============4558935948119215960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============4558935948119215960==--
