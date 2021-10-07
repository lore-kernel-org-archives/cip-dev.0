Return-Path: <SRS0=gvbs=O3=lists.cip-project.org=bounce+64572+6804+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ACEC433EF
	for <cip-dev@archiver.kernel.org>; Thu,  7 Oct 2021 11:39:35 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA8E61002
	for <cip-dev@archiver.kernel.org>; Thu,  7 Oct 2021 11:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7FA8E61002
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id q3i9YY4521723xtCrdCNt8Jz; Thu, 07 Oct 2021 04:39:34 -0700
X-Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web12.10298.1633606772037692008
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Oct 2021 04:39:33 -0700
X-Received: by mail-ot1-f51.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so7113431otv.4
        for <cip-dev@lists.cip-project.org>; Thu, 07 Oct 2021 04:39:31 -0700 (PDT)
X-Gm-Message-State: bTPZWwwj0WTlq6b1TLoSSlrsx4520388AA=
X-Google-Smtp-Source: ABdhPJx+3HOlsv/JcgNO+fCoWr+7Mw0TBcmfSQnD2cnZd7Go8qrCUS79LHKNZ6VXI/8AVp7K/Lk90WUSCztovn6M1/c=
X-Received: by 2002:a05:6830:4411:: with SMTP id q17mr2890834otv.67.1633606770814;
 Thu, 07 Oct 2021 04:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9rKixC0p_tFV=qR7sTgPqS1ZxuXJJnkPufW+z-m8NFHxA@mail.gmail.com>
 <20211007073054.GA10302@duo.ucw.cz>
In-Reply-To: <20211007073054.GA10302@duo.ucw.cz>
From: "Masami Ichikawa" <masami.ichikawa@miraclelinux.com>
Date: Thu, 7 Oct 2021 20:38:55 +0900
Message-ID: <CAODzB9omMdRDC9JxfJie63w0SA5-LKGRaPuNAAe8WbexFMsw7w@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entry this week
To: cip-dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="nJprDNZp22uV7Lj5OHI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633606774;
 bh=T4yhMGVt9/+9vR4bHq4nlPusrw+iEddqPHAHSYNXvMA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=fzYmtcd+txE3WLLKlR+uI27nv9ebZxyWETKIkx2Jmy3D3r0P71whSSyofw50YGfGfgG
 yxRzudUWI7cf9x3svvVQlMXXGyfHjZcpWLb5zY1JoyUu65opjvbGYoVbHsISkjhUvk+Tc
 6VZ/Y8O7kYadeqiMPlaUxeTxdt8lO88pth0=
Message-ID: <20211007113855.stKNR2PmFLDANn7fx2xRiE156ATXMkAeiskgz44byZ8@z>

--nJprDNZp22uV7Lj5OHI5
Content-Type: text/plain; charset="UTF-8"

Hi !

On Thu, Oct 7, 2021 at 4:31 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > It's this week's CVE report.
> >
> > This week reported  new CVEs.
> >
> > * New CVEs
> >
> > CVE-2021-41864: bpf: Fix integer overflow in prealloc_elems_and_freelist()
> >
> > CVSS v3 score is not provided.
> >
> > Patch 30e29a9a2bc6 (bpf: Fix integer overflow in
> > prealloc_elems_and_freelist()
> ...
> > Fixed status
> >
> > Fix patch has been merged into bpf tree, but not in the mainline yet.
>
> I guess we can wait for this to be merged through normal channels.
>

Yes. I'll track the patch goes into the mainline.

> > * Updated CVEs
> >
> > CVE-2019-19449: mounting a crafted f2fs filesystem image can lead to
> > slab-out-of-bounds read access in f2fs_build_segment_manager in
> > fs/f2fs/segment.c
> >
> > This patch has been merged since 5.10-rc1.
> > For 5.4, patch can be applied via git-am. For 4.4 and 4.19, patch can
> > be applied via git-am with -3 option.
> >
> > Fixed status
> >
> > mainline: [3a22e9ac71585bcb7667e44641f1bbb25295f0ce]
> > stable/5.10: [3a22e9ac71585bcb7667e44641f1bbb25295f0ce]
>
> It may make sense to help with this backport.
>
> > CVE-2021-37159: net: hso: do not call unregister if not registered
> >
> > 4.14, 4.19, and 5.4 have been fixed. 4.4 and 4.9 haven't been fixed
> > yet. However, patch can be applied to 4.4 and 4.9 without any
> > modification. According to cip-kernel-config, no CIP member use HSO
> > module.
>
> Not sure why this has CVE number. We probably need not care.

I agree.

>
> > CVE-2021-38300: bpf, mips: Validate conditional branch offsets
> >
> > This vulnerability is only affected to MIPS architecture. No cip
> > member use MIPS architecture.
> >
> > 5.10 has been fixed. Applying this fix to 4.4, 4.9, 4.19, and 5.4, it
> > needs to modify the patch.
> >
> > Fixed status
> >
> > mainline: [37cb28ec7d3a36a5bace7063a3dba633ab110f8b]
> > stable/5.10: [c61736a994fe68b0e5498e4e84e1c9108dc41075]
>
> I guess we don't care about MIPS.
>

I see. We don't have to track this CVE.

> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> 
>

Regards,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--nJprDNZp22uV7Lj5OHI5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6804): https://lists.cip-project.org/g/cip-dev/message/=
6804
Mute This Topic: https://lists.cip-project.org/mt/86134956/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--nJprDNZp22uV7Lj5OHI5--
