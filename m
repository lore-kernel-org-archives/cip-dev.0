Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7C910854DC
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 21:58:53 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26601.1773871130519240794
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2026 14:58:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=g1KyZcaD;
 spf=pass (domain: gmail.com, ip: 209.85.160.175, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506bcb23a78so28321cf.3
        for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 14:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773871129; cv=none;
        d=google.com; s=arc-20240605;
        b=N6MNNJfuwYDT/s4Li9Adr95+s1Tts1s5RE5r/IffuQIK/AXQjbySfnQcnzm/kC/lTn
         EESj582046JYW0auEGu9D3U9wfvHRzXOViXybZCVj9dnP964iiuoZ9o6P98UNEcZt/Vj
         uMNV/VS6SGp6ZPMT/YKE4n95rT/UH04mo3Jp5U+exmfeln0FsTfciHrF3QTRaPm3/IwS
         uie/vogB++V6jVA7felPZ5oW/1wmSQQMaFtWZBMZMlnNzMrs+HHbRhAD2bEvl+Ts9ISH
         IAdpohvABf9MYHRsE04sEU9idQ9ln0abpR49ot9ljRVJjprcElnTw+T5z9fxlUqGOkVY
         s4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kSrI/6abzOWHjmNpcKIvI+KHJD2b18+kzBC8j23sffE=;
        fh=CnqP7mnkDPiIm4NB1X+8VC7xjAJ6yIKa1Qlj2mA22t0=;
        b=lQkxDo14Ll0LMgNNoIaAstDlbAaQlM9vtdfSla4In1JCNG3F/J1rKHVrpUsUrbNQpm
         AUJpslKaMwGcSeowsGi+HK3Lg/BBBaHqmppFtTg3GBEOume7N9DKC1YpkjbEyGOhABLp
         PqYJmXn7/mzozud1CWGHJm5llZ+Qwq4lXKiPLnyP2B4LWn97JF6hMYtawmim4m9+jtZn
         3GNQPe2MowV7OJ5bpYpU1mPsbQnkmV3tZmZc0R17YLYNJnF7MRFaVhsIjDSYjNDRXucI
         kx+YbvLvtqymWeRxI7EtDki7FsQfgcT3uLYsbqB9LUTYChrnRzkRhlfpO8btdt+V2N0I
         3BCg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773871129; x=1774475929; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSrI/6abzOWHjmNpcKIvI+KHJD2b18+kzBC8j23sffE=;
        b=g1KyZcaD1zY8DwAhMeUFldyRbxjCtPWB90+LU8UPLCTwxrFNpnSZzyDFVqpypptfrq
         eo4M0i1mdcrBmQ8Tk0RhkI18pIRaeI5LIvnPO9C0m6jYj8kykaV7LE+nwqWfEANNjN5S
         g+ov6c5VOJn4YWtadUsmlh6tRCPt6m2YDrkgK3xdsOMqxbzS/YMP9hEahy/2pHlHyzjU
         zqeASZCZOWqbcr2aV/yH9LFASm7e+JZD2QS8+p5ACsiPpO44RBWABA3LU0C2gKeJR6nO
         5jDuH4nSUfFOxVo7qO/i+3X0a3DVL8kUFWCVFZmSTqeX3hEfUpr2U9fKKBWtxeuoVMGD
         ihCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773871129; x=1774475929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kSrI/6abzOWHjmNpcKIvI+KHJD2b18+kzBC8j23sffE=;
        b=GG/J1KKtzeSPlzCZsJN9rL4HeYUaOTnTNev59aUfbHLeyr/oVoN7Lj+VgIME9tHVg/
         RJ7nmhJmPVDbUozL1laaYuvCujfbTERyTxKqE7T90dSIFnz7hU4+iTf0OBH1Ejus9Df1
         RYB1LBp/MKbASXZ+PSAhg7XwyfylrIjPVlB4RE14R+deegNcZEeaad64jO4gUCzAUnCe
         KN/FR4B+EnHwJVpkdG0+ZhFVTCb2FwxQjGCxTG2bBgiyGJor+LWW/F0JmrKs+57DLpkI
         5mKTILvx541vmW4qkW6VNSy8oI/2LDMYyHI81C5y7aNm+8q8G6TmqRrh3ZlSrGSOWcLR
         nn5g==
X-Forwarded-Encrypted: i=1; AJvYcCWjNJEPL8HDloBFB2mOFQMxJFXogXXFr3TlSCCGANAST5VJ6zMJgRUJX8b7Pqdbf54a9+sQsmn2@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy4pB5gDIHPAMcj932K3c4zP/zyVeobDHMk96/dtEqaJW6ORqwW
	vzpYALS2BqNYmGJqBCvnDVTp8YFNReARp9Kazk88hQlV3LsJW6XwwTouSN/+Rjitm4P0xrUxGGq
	85AVGHzTEMpI/G5a7RdmBwz/8iPZ+Oqk=
X-Gm-Gg: ATEYQzzOrPl8bVi+/sMegOtxMHrAdrRQYrZBRRVnmJ8veoH4Zq+RcaYdzO3Jf1x11/+
	TilO78bhABeQZTaOwKZlwjVdWOBVsaS/mSYDuomQAYL73gnaM0rkU9HM400m3riV0XwBipLBeKz
	3kXGylfZ/omQeXxt9It7VwY9orpX1XfHCcN+ZDEFTQZ1b0yWGNrmGFW1hAv+yQnLXg20tNavYFO
	6/2YQrhZZ6yZMoaqG8fNaGiIBXNoxw3iDUePKjKPEUW63sh+logfue3nT/gdfYYTSQXUKLhKAJr
	DUA=
X-Received: by 2002:a05:622a:553:b0:509:59c:5799 with SMTP id
 d75a77b69052e-50b147a2c14mr66082281cf.21.1773871129426; Wed, 18 Mar 2026
 14:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260317113643.311192-1-biju.das.jz@bp.renesas.com> <abp6OA9YNPPSCOaq@duo.ucw.cz>
In-Reply-To: <abp6OA9YNPPSCOaq@duo.ucw.cz>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Thu, 19 Mar 2026 06:58:38 +0900
X-Gm-Features: AaiRm52BAGp5Uupl2pnfS1I4gbvtlc8riQMXCXfgDDeUpkoUeAR1N6bGR5caAzM
Message-ID: <CACe6DC5-+FhQC6NLqCEBwA0t3OytAaKg=jN9us-ohcXZpC5jKQ@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/11] Add Renesas RZ/G3E USB3.2 Gen1
 Host Controller support
To: pavel@nabladev.com
Cc: Biju <biju.das.au@gmail.com>, cip-dev@lists.cip-project.org, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 21:58:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22503

Hi all,

2026=E5=B9=B43=E6=9C=8818=E6=97=A5(=E6=B0=B4) 19:11 Pavel Machek via lists.=
cip-project.org
<pavel=3Dnabladev.com@lists.cip-project.org>:
>
> Hi!
>
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Hi All,
> >
> > Add Renesas RZ/G3E USB3.2 Gen1 Host Controller and PHY support. The
> > USB3 HOST is compliant with the Universal Serial Bus 3.2
> > Specification
>
> I had some minor comments here, but those should be fixed in mainline,
> first, so they should not block the merge.
>
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>
> I can apply the series if it passes testing and there are no other
> comments.

I reviewed this series, looks good to me too.
I applied with Pavel's reviewed-by tag, thanks.

>
> Best regards,
>                                                                 Pavel
>
Best regards,
  Nobuhiro

