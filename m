Return-Path: <SRS0=HI+E=LL=lists.cip-project.org=bounce+64572+6530+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56012C49361
	for <cip-dev@archiver.kernel.org>; Thu, 17 Jun 2021 11:04:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7557613E9
	for <cip-dev@archiver.kernel.org>; Thu, 17 Jun 2021 11:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7557613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6530+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dkczYY4521723xHoN4GaS7uf; Thu, 17 Jun 2021 04:04:14 -0700
X-Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
 by mx.groups.io with SMTP id smtpd.web08.6080.1623927853660804773
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Jun 2021 04:04:13 -0700
X-Received: by mail-il1-f174.google.com with SMTP id p14so5007103ilg.8
        for <cip-dev@lists.cip-project.org>; Thu, 17 Jun 2021 04:04:13 -0700 (PDT)
X-Gm-Message-State: qSTzBGkfDC03dXx0r88uo0YFx4520388AA=
X-Google-Smtp-Source: ABdhPJwAdXhWFYuNcr7dnHLzOlE4Ma5EoiWeE7bzhpiaQ8FCIYS/Vg5nb7Fd7p7v4+mpnw3LqFag8G4BuGGgNhM5dhQ=
X-Received: by 2002:a05:6e02:1b07:: with SMTP id i7mr3013841ilv.33.1623927852601;
 Thu, 17 Jun 2021 04:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210610170538.GA12973@amd> <CAODzB9rvyCg+=EctmFES3K+_Zi9pOxBJP5AWS8X6to311sscBw@mail.gmail.com>
In-Reply-To: <CAODzB9rvyCg+=EctmFES3K+_Zi9pOxBJP5AWS8X6to311sscBw@mail.gmail.com>
From: "Masami Ichikawa" <masami256@gmail.com>
Date: Thu, 17 Jun 2021 20:04:01 +0900
Message-ID: <CACOXgS-O+Rs6rGnPiYVo7x=X3V1Qz4uCiAG53jdSnm6jtZwKMA@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries this week
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="BUfKbWOISFxiYIMIy2ty"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623927854;
 bh=7b6Gw1IKthUTzBoFAioGsOUvW0WBvcvUrVWhjQFITX0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=E/MdyAqaTWynRULk9m2bLcAyd8kQtYJ98TEpmtAfK4PBbSO74X9JuXTpnt38SpJ5SD3
 TWqZ8erHCOXKu2r7nhdnd6F47tMXBoWOBl7S1qPTFjdInQ4iWcnjC3pguXaCgkSGv82E8
 VnioJr0ulm7QO+3cmUl+rHoEvfVntpAbVCI=

--BUfKbWOISFxiYIMIy2ty
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

Please ignore my 2nd email from masami.ichikawa@cybertrust.co.jp.
It's my mistake.

Cheers,

On Thu, Jun 17, 2021 at 7:55 PM =E5=B8=82=E5=B7=9D=E6=AD=A3=E7=BE=8E <masa=
mi.ichikawa@cybertrust.co.jp> wrote:
>
> Hi!
>
> 2021=E5=B9=B46=E6=9C=8811=E6=97=A5(=E9=87=91) 2:05 Pavel Machek <pavel@d=
enx.de>:
> >
> > Hi!
> >
> > These are the new issues this week:
> >
> > Best regards,
> >                                                                 Pavel
> >
> > * 2021-06-04
> >
> > CVE-2021-33200 -- BPF fix turned out to be buggy.
> >
> > * 2021-06-09
> >
> > CVE-2021-0606 -- EoP in GPU DRM Driver / reported by android, probably=
 upstream commit e7cdf5c82f1773c3386b93bbcf13b9bfff29fa31 ... may be intere=
sting?
> >
> > CVE-2021-3587 -- redhat Bugzilla 1968057: CVE-2021-3587 kernel: nfc: N=
ull pointer dereference in llcp_sock_getname
> >
> > CVE-2020-36385 -- An issue was discovered in the Linux kernel before 5=
.8.1. net/bluetooth/hci_event.c has a slab out-of-bounds read in hci_extend=
ed_inquiry_result_evt, aka CID-51c19bf3d5cf.
> >
>
> According to the  CVE-2020-36385.yml it describes 'RDMA/ucma: Rework
> ucma_migrate_id() to avoid races with destroy'. However According to
> the  CVE-2020-36385.yml it describes 'RDMA/ucma: Rework
> ucma_migrate_id() to avoid races with destroy'. However, the
> description of 'An issue was discovered in the Linux kernel before
> 5.8.1 ...' seems like CVE-2020-36386.
>
> > CVE-2020-36387 -- An issue was discovered in the Linux kernel before 5=
.8.2. fs/io_uring.c has a use-after-free related to io_async_task_func and =
ctx reference holding, aka CID-6d816e088c35.
> >
> >
> >
> >
> >
> >
> >
> >
> > --
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> >
> >
> >
>
>=20
>


--=20
/**
* Masami Ichikawa
* personal: masami256@gmail.com
* fedora project: masami@fedoraproject.org
*/

--BUfKbWOISFxiYIMIy2ty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6530): https://lists.cip-project.org/g/cip-dev/message=
/6530
Mute This Topic: https://lists.cip-project.org/mt/83449660/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--BUfKbWOISFxiYIMIy2ty--
