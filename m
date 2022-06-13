Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4A4C433EF
	for <webhook@archiver.kernel.org>; Mon, 13 Jun 2022 15:16:27 +0000 (UTC)
Subject: Re: Reported 4.4.y-st issue from Flamefire #cip
To: cip-dev@lists.cip-project.org
From: theflamefire89@gmail.com
X-Originating-Location: Dresden, Saxony, DE (217.254.148.24)
X-Originating-Platform: Linux Firefox 101
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 13 Jun 2022 08:16:21 -0700
References: <20220603095930.GA1095@duo.ucw.cz>
In-Reply-To: <20220603095930.GA1095@duo.ucw.cz>
Message-ID: <5284.1655133381155499357@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="CH3Eufe5wpP6MIMeF4xq"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jun 2022 15:16:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8554

--CH3Eufe5wpP6MIMeF4xq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

> Unfortunately, mainline seems to be different here. Looking at the
> code, is min < 0 in your case?

yes "min" is negative. IIRC min and max are centered around zero. And as li=
nked above a similar function has the adjustment and others independently c=
ame up with the same fix. I also verified that it fixes my issue.

Best Regards,

Alex

--CH3Eufe5wpP6MIMeF4xq
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>Hi,<br /><br />&gt; Unfortunately, mainline seems to be different here. =
Looking at the<br />&gt; code, is min &lt; 0 in your case?<br /><br />yes "=
min" is negative. IIRC min and max are centered around zero. And as linked =
above a similar function has the adjustment and others independently came u=
p with the same fix. I also verified that it fixes my issue.<br /><br />Bes=
t Regards,</p>
<p>Alex</p>

--CH3Eufe5wpP6MIMeF4xq--

