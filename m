Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B514C636CD
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 13:43:42 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.23124.1675258640953921623
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Feb 2023 05:37:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=SXlQ4L+X;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: error27@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so1459073wms.1
        for <cip-dev@lists.cip-project.org>; Wed, 01 Feb 2023 05:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L2WcUKHhKYf5KPZ91tTZraIDIh2DjwbXsYCtx5pIpUg=;
        b=SXlQ4L+XhRAzV1V3OEbm01m6LX8m+4lc2U3zdNH/QKP4CjSvyqv4iU8i66JsLBoelU
         Zk7RDxuBAEOXzWpRGH6b/B2fqlZYbHu3EEePj/tAHOMw128QQk/7CGqJYqPwe3wFvzDJ
         MicLyy9mf67ZLVk87krdA8eTAp9l+WhaPTizlx1+aih+tFfZfjvteoTFiylLqmwBjh1G
         OCaNMiq4bqo8/EhIuPdTFCBusRlsfaInD5mNE8PKKv6WMUjXkodacDG85usfWfCgHSzX
         ti22HT63KvAfe1rb2VCWZ4gkDIQptROZ/i1mc21sspxbPJGzbYihe924n4sgxzETY3x/
         H5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2WcUKHhKYf5KPZ91tTZraIDIh2DjwbXsYCtx5pIpUg=;
        b=Ubo6KcVdjLSxQx5bxMcQUyn75Pr9/S/QEKfA3oRd3KDCTSBKASf8JqwP5a0ol+o8Ev
         rOqQLBRa9s9PtrgcqdmIG8vCe/trQOg0SKnLJDj1btZCyvvxhNCestONa5sbNqHZSdKd
         BOx+7jbTk97lA7brW+aiVOyB9nYZaojaavKv3ci/yk/Lgr9jD5nz51bImIzX7WZNlTJB
         rNkEoNBzqAmAuIbObyVLMURQnG1Y+ZWYoFUktTQnWoVzaBNfU7+Zj8EnIvzrWjtBhYHm
         lumBznzJbRMFBpPxqKVGVDpY5MqG7VJzu9VXUVpQtzG7xWmF9zW7IFR990wkGmUX278h
         dsdg==
X-Gm-Message-State: AO0yUKWCjYmhLpVS9vA+OinYd3+iyGckl42mbXBa8tUxvVQEDM1Ue0Ia
	zM4h32yaCNdIYXZQ+kuXNhw=
X-Google-Smtp-Source: AK7set+SAkcIs5rfXITrkT0pTHpCFfl3mQN1WwmkzEiYXYibM5ijVYFwVLVml2c6/95foDLxaGYsBQ==
X-Received: by 2002:a05:600c:4fd1:b0:3dd:1ac2:989 with SMTP id o17-20020a05600c4fd100b003dd1ac20989mr7509937wmq.39.1675258639350;
        Wed, 01 Feb 2023 05:37:19 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c2cb200b003dd1bd66e0dsm2008961wmc.3.2023.02.01.05.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 05:37:18 -0800 (PST)
Date: Wed, 1 Feb 2023 16:37:14 +0300
From: Dan Carpenter <error27@gmail.com>
To: sujuan.chen@mediatek.com
Cc: linux-mediatek@lists.infradead.org,
	Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: [bug report] net: ethernet: mtk_wed: introduce wed mcu support
Message-ID: <Y9prChfI3ExTpK2o@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Feb 2023 13:43:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10557

Hello Sujuan Chen,

The patch cc514101a97e: "net: ethernet: mtk_wed: introduce wed mcu
support" from Nov 5, 2022, leads to the following Smatch static
checker warning:

	drivers/net/ethernet/mediatek/mtk_wed_mcu.c:82 mtk_wed_update_rx_stats()
	warn: uncapped user loop index 'i'

drivers/net/ethernet/mediatek/mtk_wed_mcu.c
    64 static void
    65 mtk_wed_update_rx_stats(struct mtk_wed_device *wed, struct sk_buff *skb)
    66 {
    67         u32 count = get_unaligned_le32(skb->data);
    68         struct mtk_wed_wo_rx_stats *stats;
    69         int i;
    70 
    71         if (count * sizeof(*stats) > skb->len - sizeof(u32))
    72                 return;

There are two issues.

Bug 1: There is no check that skb->len >= sizeof(u32) so the
get_unaligned_le32(skb->data); can result in an out of bounds read and
the bounds check on count is not effective.

Bug 2: On a 32bit system the "count * sizeof(*stats)" multiplication can
have an integer overflow bug.  Suggestion:

	if (size_mul(count, sizeof(*stats)) > skb->len - sizeof(u32))
		return;

    73 
    74         stats = (struct mtk_wed_wo_rx_stats *)(skb->data + sizeof(u32));
    75         for (i = 0 ; i < count ; i++)
--> 76                 wed->wlan.update_wo_rx_stats(wed, &stats[i]);
    77 }

regards,
dan carpenter

