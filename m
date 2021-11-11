Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2971C433EF
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 12:48:22 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by mx.groups.io with SMTP id smtpd.web10.10147.1636634900521764064
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Nov 2021 04:48:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=ct5zpVNi;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.176,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f176.google.com with SMTP id bf8so11369858oib.6
        for <cip-dev@lists.cip-project.org>;
 Thu, 11 Nov 2021 04:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Yut0VfjyfNmfBVK/HrMohfko3Q3gb9FovDlV5cJHZJY=;
        b=ct5zpVNijwo7Z5nH1C2h48d6R5tKkqctHxNf0x36xZLrTwT3wD4QwZV1ocgEIP26RH
         3w55sN6S9Q3V+l2INtRHrLbdCJ6wt6KyOoUZeE8isTB4ded2CKYyBs8kjnXZs8EnOiS1
         NhtF+7GmlYbmCt7MprPkIS3EtxAGQPL6zg1k2Yt1ShifuusZppnd+Dufku0KX7cjQ2cK
         Ab547mCH8+xCDCB3MUF7Jbh/S81YGv/bkecEiBKeUDpweoNYjIyfoB6F5J4A1o/BPlE3
         h4BNMWK88FkxPjswQr2F8JDyUvzKN7ESSMMh/5F4gkbYxGEoB7DYUXJlSwiEyWLlCIey
         +ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Yut0VfjyfNmfBVK/HrMohfko3Q3gb9FovDlV5cJHZJY=;
        b=RnlKQo8Dct7QmJgZplGm1Vxmo0sNx1/I+YhUaprsThP/0HAgjoxSA6yi8hyqoETl89
         oSGYv/XDEHUL77B4mcnjTN0FC0AEaKje+j63IpBiEWJXYTMX1X2Cpj4vBgaSUUaOvtNh
         Ai9NckLb4V1b4NSgylpH8nrNoY2LxXjqWtElAN53wbCduRQlnyjQUGtJkyYOFC7SLeTs
         bSxrtf8fD88zkHXT3HV+2OKK/9WwBEaja+NwfFIlsagee9IXD2cjUtYb+ADRo6U9nojY
         PA3tjrlgvnAwTN9JOlTRKfOrH1swqEjFLn1X8s6+B0Y/Pn6peH9O8LrTNAyPUumMhPoI
         ltUg==
X-Gm-Message-State: AOAM5324lcMnyw24/X5cu8QyFUZGsABVFUvP1KLleaO9zzVKPrO0NlhD
	wVyLpVhInrvjGjntPAaTFOSUyErIyMJTm0WEnrmquVo9ocRU4A==
X-Google-Smtp-Source: 
 ABdhPJyYNaoXtZJJFrNj3cW2u837O8Rw/z5JgNGvIQ8QWhV4F5/VEwNUyCDTQESKvg0zPEIA0aUOwT625A4Rvl/pKfk=
X-Received: by 2002:aca:c654:: with SMTP id w81mr6023499oif.66.1636634899435;
 Thu, 11 Nov 2021 04:48:19 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAODzB9okpxqQ9ezVD0ua8wKqCjo=j1zw0pU18v7gmE=r1KGOQg@mail.gmail.com>
 <20211111092138.GA8515@amd>
In-Reply-To: <20211111092138.GA8515@amd>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 11 Nov 2021 21:47:43 +0900
Message-ID: 
 <CAODzB9pef4KWvAHAaHSOPPdX0Ks82XhvBGgGbG=eJj9bf8gSDQ@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries in this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Nov 2021 12:48:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6877

Hi !

On Thu, Nov 11, 2021 at 6:21 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > CVE-2021-0929: staging: ion: move buffer kmap from begin/end_cpu_access()
> >
> > CVSS v3 score is not provided.
> >
> > ION is a memory manager which is used by Android. This CVE may affect
> > 4.4, 4.19, and 5.10 however according to the cip-kernel-config, no cip
> > member enabled ION. The ION driver has been removed since 5.11.
> >
> > Fixed status
> >
> > mainline: [3e9e0c5c764704218c0960ffdb139de075afaadf]
>
> Furthermore, CIP members should really not be using code from staging.
>
> > * Updated CVEs
> >
> > CVE-2021-42739: media: firewire: firedtv-avc: fix a buffer overflow in
> > avc_ca_pmt()
> >
> > 4.19 and 5.X kernels have been fixed in this week. However, appliying
> > patch to 4.4 and 4.9 are failed.
> > According to the cip-kernel-config repo, no CIP member uses firewire driver.
>
> This one looks rather easy to backport. It failed only because
> reformatting of the printk.
>

Thank you for the patch! The patch looks good to me.

> > CVE-2021-3640: UAF in sco_send_frame function
> >
> > Fixed commit is 99c23da0eed4fd20cae8243f2b51e10e66aa0951 ("Bluetooth:
> > sco: Fix lock_sock() blockage by memcpy_from_msg()"). Backport patches
> > for 4.19, 5.4, 5.10, 5.14, and 5.15 have been sent to stable mailing
> > list on Nov 9. This fix can be applied to 4.4 by git-am without error.
> >
> > mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951]
>
> Would it make sense to ask why it was not applied?
>

Yes, I think so.

> Best regards,
>                                                                 Pavel
>
> diff --git a/drivers/media/firewire/firedtv-avc.c b/drivers/media/firewire/firedtv-avc.c
> index 280b5ffea592..3a373711f5ad 100644
> --- a/drivers/media/firewire/firedtv-avc.c
> +++ b/drivers/media/firewire/firedtv-avc.c
> @@ -1169,7 +1169,11 @@ int avc_ca_pmt(struct firedtv *fdtv, char *msg, int length)
>                 read_pos += program_info_length;
>                 write_pos += program_info_length;
>         }
> -       while (read_pos < length) {
> +       while (read_pos + 4 < length) {
> +               if (write_pos + 4 >= sizeof(c->operand) - 4) {
> +                       ret = -EINVAL;
> +                       goto out;
> +               }
>                 c->operand[write_pos++] = msg[read_pos++];
>                 c->operand[write_pos++] = msg[read_pos++];
>                 c->operand[write_pos++] = msg[read_pos++];
> @@ -1181,13 +1185,17 @@ int avc_ca_pmt(struct firedtv *fdtv, char *msg, int length)
>                 c->operand[write_pos++] = es_info_length >> 8;
>                 c->operand[write_pos++] = es_info_length & 0xff;
>                 if (es_info_length > 0) {
> +                       if (read_pos >= length) {
> +                               ret = -EINVAL;
> +                               goto out;
> +                       }
>                         pmt_cmd_id = msg[read_pos++];
>                         if (pmt_cmd_id != 1 && pmt_cmd_id != 4)
>                                 dev_err(fdtv->device, "invalid pmt_cmd_id %d "
>                                         "at stream level\n", pmt_cmd_id);
>
> -                       if (es_info_length > sizeof(c->operand) - 4 -
> -                                            write_pos) {
> +                       if (es_info_length > sizeof(c->operand) - 4 - write_pos ||
> +                           es_info_length > length - read_pos) {
>                                 ret = -EINVAL;
>                                 goto out;
>                         }
> diff --git a/drivers/media/firewire/firedtv-ci.c b/drivers/media/firewire/firedtv-ci.c
> index e63f582378bf..f07482fb8010 100644
> --- a/drivers/media/firewire/firedtv-ci.c
> +++ b/drivers/media/firewire/firedtv-ci.c
> @@ -138,6 +138,8 @@ static int fdtv_ca_pmt(struct firedtv *fdtv, void *arg)
>         } else {
>                 data_length = msg->msg[3];
>         }
> +       if (data_length > sizeof(msg->msg) - data_pos)
> +               return -EINVAL;
>
>         return avc_ca_pmt(fdtv, &msg->msg[data_pos], data_length);
>  }
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#6876): https://lists.cip-project.org/g/cip-dev/message/6876
> Mute This Topic: https://lists.cip-project.org/mt/86970992/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129101/4520416/1465703922/xyzzy [masami.ichikawa@miraclelinux.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

Regards,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

