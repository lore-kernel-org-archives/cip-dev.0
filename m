Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88470C3600E
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 22:39:53 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
 by mx.groups.io with SMTP id smtpd.web11.37095.1743028784727985920
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Mar 2025 15:39:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=zGhhfu7R;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.172, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e694601f624so84800276.1
        for <cip-dev@lists.cip-project.org>; Wed, 26 Mar 2025 15:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1743028784; x=1743633584; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mXYs2mi3GOc5UojcQMmi8k3m5VM8uAOV2TiXaNFuZvo=;
        b=zGhhfu7Ry6/tcDxqpIW5r44dN8cE62hUPBjyMbfnWF9XlwG0bLlv4a6H1hDC9z4vXK
         h0JqWHA+wiZH7z5DfEdTwPQWtkwiwAYlW83IsbQhNy8yaxClnQqLo/hgT5BSAZd7vnjv
         GgwJJyw43GyJCOwySNDyfywjS1X1YyMzpF9gvtt9xhzEMBbLtoCpFi8Vg9Pc2lTBKDGS
         2kYr/V0P3dLgMqKXQ1qn6U6Lam5YPeUJGKyagWDbMlrPkgb2TQIzEMnx1INW2sm2mK99
         IcV1PtkYEc12E0+nfRcxupE+FQtEEN2n2zOd2CphhzONVAI4kCoyVInQFMkjcrHi/RiY
         yxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743028784; x=1743633584;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mXYs2mi3GOc5UojcQMmi8k3m5VM8uAOV2TiXaNFuZvo=;
        b=YbKQb3yN69bKu04hD/c7Eg+gll4gvcIF8hkb71HwQJNI3JNBmBwtGwcmGSHvVJe6vB
         CUINXjmul4FaZMwCQRNvxA2juBO196XFsnGxIKLdjvxosPcXNadiB4iwvsQkXjSq2Rf3
         QxVV9Nm6TGRM5XxKh6N+ZAYq6V3FXADPUNP6DI3Pq5+sB9fPHqlhW7DTSyLHtGMn+eCr
         KWWMSpwql4PKGvLd86GGH3Z7OngbkybTqf5jgYFTmllWBrOtzC5tPP6Pb6OiGMurDQ71
         ds6V3qcH+6qOO5UkJQfhF6Tg7IdJ6T6sTqI7lXOYIsapXomDicgyT9OQGLsmMOvxfUb0
         PQJw==
X-Gm-Message-State: AOJu0Yw4hbnuGCjIKAWhqRDDp4unvA9RNzr13k6Z1ckwEje+pzwYGrkb
	59YehVHCJ1Zr33OlX6ClsoRS7d5WCj3QaDB6XT8m1fcVBhDlvSVABxYGgi57TU/P4ujfb0sB4tf
	Hdc9kUnzeSNpsoG1u0b7V08SNrRD7omK4qpwrvLEwUEjdGVJNN98=
X-Gm-Gg: ASbGncus9gUdUV+R2wk3byZGpDOI+h1tui9mBH5fdR7UEs4B1hsVlsIIUPgSCgKIwkT
	z222IIiye8XlyiOAqMEthGE3xgTXbvU8Nyel3Fqq7V7DF5SxNJSWhcU8Fx4gVREXGJYbrzJ7Oy9
	tzbYcoU+z15JD8BLWS4BV/ijSipyo=
X-Google-Smtp-Source: AGHT+IE+JFw3bXBUdifr9GBQccI4xfM3uL7/daaI2sgwA0/jgO/XtyABFmPtgqcjspLPdudQClTrBY+xP2e05Mw5l4k=
X-Received: by 2002:a05:6902:1687:b0:e60:aed6:578d with SMTP id
 3f1490d57ef6-e69435b6fe5mr2644980276.27.1743028783370; Wed, 26 Mar 2025
 15:39:43 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 27 Mar 2025 07:39:07 +0900
X-Gm-Features: AQ5f1Jp5By4uaUIRgZz6AAHpNS6yVHECg9yaudmdMevIh3YUL7CdNuXmYVTm5HE
Message-ID: <CAODzB9r_z-7BO6iPtjAjmLh_7rqyQQz=OOSLv1M9u-mT9pz6JQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Mar 2025 22:39:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18372

Hi!

It's this week's CVE report.

This week reported 0 new CVEs and 4 updated CVEs.

* New CVEs

No new CVEs this week.

Fixed status

* Updated CVEs

CVE-2024-27397: netfilter: nf_tables: use timestamp to check for set
element timeout

stable/6.6 was fixed.

Fixed status
cip/4.19: [f8dfda798650241c1692058713ca4fef8e429061]
cip/4.19-rt: [f8dfda798650241c1692058713ca4fef8e429061]
cip/4.19-st: [f8dfda798650241c1692058713ca4fef8e429061]
stable/4.19: [f8dfda798650241c1692058713ca4fef8e429061]
stable/5.10: [7b17de2a71e56c10335b565cc7ad238e6d984379]
stable/5.15: [0d40e8cb1d1f56a994cdd2e015af622fdca9ed4d]
stable/5.4: [eaf1a29ea5d7dba8e84e9e9f3b3f47d0cd540bfe]
stable/6.1: [b45176b869673417ace338b87cf9cdb66e2eeb01]
stable/6.6: [7fa2e2960fff8322ce2ded57b5f8e9cbc450b967]

CVE-2024-50138: bpf: Use raw_spinlock_t in ringbuf

stable/6.6 was fixed.

Fixed status
stable/6.1: [5eb34999d118e69a20dc0c6556f315fcb0a1f8d3]
stable/6.11: [ca30e682e5d6de44d12c4610767811c9a21d59ba]
stable/6.6: [f9543375d9b150b2bcf16bb182e6b62309db0888]

CVE-2024-53222: zram: fix NULL pointer in comp_algorithm_show()

stable/6.6 was fixed.

Fixed status
stable/6.12: [843d366ff19708668d95cda16bb8aba109a93dba]
stable/6.6: [c7ee791e538537b281f60945298796f0a3971bbd]

CVE-2024-40993: netfilter: ipset: Fix suspicious rcu_dereference_protected()

stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [72d9611968867cc4c5509e7708b1507d692b797a]
stable/5.15: [523bed6489e089dd8040e72453fb79da47b144c2]
stable/5.4: [3799d02ae4208af08e81310770d8754863a246a1]
stable/6.1: [788d585e62f487bc4536d454937f737b70d39a33]
stable/6.6: [94dd411c18d7fff9e411555d5c662d29416501e4]
stable/6.9: [3fc09e1ca854bc234e007a56e0f7431f5e2defb5]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

