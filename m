Return-Path: <SRS0=dsOr=5K=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A73C1975A
	for <cip-dev@archiver.kernel.org>; Wed, 25 Mar 2020 16:34:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 076A420740
	for <cip-dev@archiver.kernel.org>; Wed, 25 Mar 2020 16:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NgRN6Pp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076A420740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BD5F986A9B;
	Wed, 25 Mar 2020 16:34:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uoCKpSpOC+I1; Wed, 25 Mar 2020 16:34:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 20A6E85EA7;
	Wed, 25 Mar 2020 16:34:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07C7BC0177;
	Wed, 25 Mar 2020 16:34:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D62F7C1D74
 for <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2020 16:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BFF2A875D1
 for <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2020 16:34:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X8ZJ4fJiMpgB for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2020 16:34:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com
 [209.85.166.52])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 01CA9871C0
 for <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2020 16:34:12 +0000 (UTC)
Received: by mail-io1-f52.google.com with SMTP id c19so2884981ioo.6
 for <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2020 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=DITXQbGW/b472iF6G9AaJA0ofR6InO/EcNFYujQV8tI=;
 b=NgRN6Pp2vx0eN+fn2AHTDI7vsWn52osxncvg1/Ib3sn03iTTzee+TMby1wzhVMOe3d
 QiyGiHnFJXlnoea+0hPB2beUsvCNI5WtF7PFwvZ2xnWgc8PEG68LJb0Cu5OHJoTMWspi
 i1MHQgRn9L66KdnN4hKDFyvmCGozn7zDCc6GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=DITXQbGW/b472iF6G9AaJA0ofR6InO/EcNFYujQV8tI=;
 b=L1JKcOaljh5StxKUSnBAetBAiFPOkSRGG8lVwnokfkEI2HH4Ofr8FQCMrdqH1mAQ/Z
 KTJ+SRj3zsKy5RaF9R5S9Gxha+w8nvJwMg061nNoAQ3+s5sDrsPGF6zW4sImIYaQ8okn
 394xKPQ6gmBBLjflA49N484zjBpESXlPdD3fX3cKMxrMcKa8tzdCXZU7NAUTa7NwqHWe
 OGdmMzanhlksjRsC6OXKVpYolmRvmmCYYzXGj9Y18FVWCgJfB4PIKy635sg7+xbG4nWB
 As6R6d1Ta38g4LzW1FsbYZxuvY9R0YWTui7AZeSHBZ2JnNlao/sTEEvo8IJFQtI9YMMc
 RzPw==
X-Gm-Message-State: ANhLgQ0GilYiK17ofPd4EX1AJOkDkEqJ/CEOeQabFODtZ2APDcap84c0
 G06v9NBMw5lYLzED38IzEZVTzsAAkSf0hxDs3T1H8VTcpJY=
X-Google-Smtp-Source: ADFU+vsCURMPjimmWuY9YiwL3dqc8qtn1XS8thRCxCCVFz0FSMUv8KM6vdY7Kc6W42Xa5iEmuq8aIhwh8eeuoBMyiq0=
X-Received: by 2002:a05:6602:24d5:: with SMTP id
 h21mr3710512ioe.154.1585154052069; 
 Wed, 25 Mar 2020 09:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAODMxsLOOk7EZwoUgd5fNpXpOoR16ZunzZe0W6nL5NrLN2JWSw@mail.gmail.com>
In-Reply-To: <CAODMxsLOOk7EZwoUgd5fNpXpOoR16ZunzZe0W6nL5NrLN2JWSw@mail.gmail.com>
From: Neal Caidin <ncaidin@linuxfoundation.org>
Date: Wed, 25 Mar 2020 12:33:56 -0400
Message-ID: <CAODMxsJ3UzAghVfLpHQ1eiizowpWUi0q5WvYxtSOYbKi36TdEw@mail.gmail.com>
To: cip-members@lists.cip-project.org, cip-board@lists.cip-project.org, 
 cip-security@lists.cip-project.org, cip-dev@lists.cip-project.org
Subject: [cip-dev] Update - Re: April 6 cutover from Mailman2 to Group.io
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
Content-Type: multipart/mixed; boundary="===============5836439075189547625=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

--===============5836439075189547625==
Content-Type: multipart/alternative; boundary="00000000000030408205a1b070f8"

--00000000000030408205a1b070f8
Content-Type: text/plain; charset="UTF-8"

Dear CIP community,

I have learned more information about the cutover plans. The migration is
planned to start at 2 pm Pacific time on April 6, which is :
5 pm Eastern / 11 pm CET / and Tuesday, April 7 , 6 am JST

The migration will probably take just a few hours, but the migration team
would like to reserve 24 hours in case they run into any issues with
transferring the archives into the new system.

I'll send more information about the migration as I learn more and as we
get closer to the conversion date.

Thanks for your patience and understanding.

Best regards,
Neal

*Neal Caidin*
Program Manager, Program Management & Operations
The Linux Foundation
+1 (919) 238-9104 (w/h)
+1 (919) 949-1861 (m)
ncaidin@linuxfoundation.org


On Thu, Mar 12, 2020 at 3:50 PM Neal Caidin <ncaidin@linuxfoundation.org>
wrote:

> [x-posted]
> Dear CIP community,
>
> These Mailman2 email lists will be converted starting on Monday, April 6
> and may take up to 24 hours to complete.
>
> There is no action required on your part.
>
> Any emails that are sent during the downtime will be queued up and come
> through when the system is up and running.
>
> Please let me know if you have any questions.
>
> Best regards,
> Neal
>
> *Neal Caidin*
> Program Manager, Program Management & Operations
> The Linux Foundation
> +1 (919) 238-9104 (w/h)
> +1 (919) 949-1861 (m)
> ncaidin@linuxfoundation.org
>

--00000000000030408205a1b070f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Dear CIP community,</div><div dir=3D"ltr"=
><br></div><div>I have learned more information about the cutover plans. Th=
e migration is planned to start at 2 pm Pacific time on April 6, which is :=
</div><div>5 pm Eastern / 11 pm CET / and Tuesday, April 7 , 6 am JST=C2=A0=
</div><div><br></div><div>The migration will probably take just a few hours=
, but the migration team would like to reserve 24 hours in case they run in=
to any issues with transferring=C2=A0the archives into the new system.</div=
><div><br></div><div>I&#39;ll send more information about the migration as =
I learn more and as we get closer to the conversion date.</div><div><br></d=
iv><div>Thanks for your patience and understanding.</div><div><br></div><di=
v>Best regards,</div><div>Neal</div><div><br></div><div dir=3D"ltr"><div><d=
iv dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"=
><div dir=3D"ltr"><div><div dir=3D"ltr"><span><font color=3D"#888888"><div =
dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><d=
iv dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><b style=3D"color:rgb(136,=
136,136)"><font color=3D"#666666"><font color=3D"#888888">Neal Caidin</font=
></font></b><br><div style=3D"color:rgb(136,136,136)"><span style=3D"border=
-collapse:collapse"><div><font color=3D"#666666"><font>Program Manager, Pro=
gram Management &amp; Operations</font></font></div><div><font color=3D"#66=
6666"><font>The Linux Foundation</font></font></div><div><font color=3D"#66=
6666">+1 (919) 238-9104 (w/h)<br>+1 (919) 949-1861 (m)</font></div><div><fo=
nt color=3D"#666666"><a href=3D"mailto:ncaidin@linuxfoundation.org" target=
=3D"_blank">ncaidin@linuxfoundation.org</a></font></div></span></div></div>=
</div></div></div></div></div></div></div></div></font></span></div></div><=
/div></div></div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Mar 12, 2020 at 3:50 PM Neal Caidin &lt;<a hre=
f=3D"mailto:ncaidin@linuxfoundation.org">ncaidin@linuxfoundation.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div di=
r=3D"ltr"><div>[x-posted]</div>Dear CIP community,<div><br></div><div>These=
 Mailman2 email lists will be converted starting on Monday, April 6 and may=
 take up to 24 hours to complete.=C2=A0</div><div><br></div><div>There is n=
o action required on your=C2=A0part.=C2=A0</div><div><br></div><div>Any ema=
ils that are sent during the downtime will be queued up and come through wh=
en the system is up and running.</div><div><br></div><div>Please let me kno=
w if you have any questions.</div><div><br></div><div>Best regards,</div><d=
iv>Neal</div><div><br></div><div><div><div dir=3D"ltr"><div dir=3D"ltr"><di=
v><div dir=3D"ltr"><span><font color=3D"#888888"><div dir=3D"ltr"><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div =
dir=3D"ltr"><div dir=3D"ltr"><b style=3D"color:rgb(136,136,136)"><font colo=
r=3D"#666666"><font color=3D"#888888">Neal Caidin</font></font></b><br><div=
 style=3D"color:rgb(136,136,136)"><span style=3D"border-collapse:collapse">=
<div><font color=3D"#666666"><font>Program Manager, Program Management &amp=
; Operations</font></font></div><div><font color=3D"#666666"><font>The Linu=
x Foundation</font></font></div><div><font color=3D"#666666">+1 (919) 238-9=
104 (w/h)<br>+1 (919) 949-1861 (m)</font></div><div><font color=3D"#666666"=
><a href=3D"mailto:ncaidin@linuxfoundation.org" target=3D"_blank">ncaidin@l=
inuxfoundation.org</a></font></div></span></div></div></div></div></div></d=
iv></div></div></div></div></font></span></div></div></div></div></div></di=
v></div>
</blockquote></div></div>

--00000000000030408205a1b070f8--

--===============5836439075189547625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============5836439075189547625==--
