Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FDECCFA04
	for <webhook@archiver.kernel.org>; Wed, 25 Sep 2024 22:19:01 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
 by mx.groups.io with SMTP id smtpd.web10.29290.1727302734121708059
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Sep 2024 15:18:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=SZF2UoHd;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.173, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e03e9d1f8dso261257b6e.2
        for <cip-dev@lists.cip-project.org>; Wed, 25 Sep 2024 15:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1727302733; x=1727907533; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D1Xo+Q3DV+FWh6KOWPN258GD6iOEqHkaZgaBSVXZvqA=;
        b=SZF2UoHdbwil6Jg1eoT15NDYXEn81Te8GR49OWyVKcuMKBrAE5dJcMPgxZojmX/Pgt
         tIQEgVKio29orcNJZo+DifoA5FDps7ZJKIbkzyIvqpXbBPpFFCGvbdkuToL5rN/eN58+
         Dqif76xRAEBcWjskPgelooxVZr16o7G3xmtLlnYP6NfNGwEakWcNirm/4u05llc7Rvs4
         8tMdgDuSCplTF3UbH9U2PEt09IyN8fmDNIZtJqGvRBJs0VdWnY4d2wD5HhtRddYEhdyJ
         FCKbAjd4fevlDawq9rLu4wg0XJbwZ6DRCFw50NRDg9q7+41OAs1xHhrGa3TrDJWBdOWo
         jiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727302733; x=1727907533;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1Xo+Q3DV+FWh6KOWPN258GD6iOEqHkaZgaBSVXZvqA=;
        b=IVmMuGV9BfCrddwAifJHIE3Qosy0CoXG9zXIOkcPtoBExR12PpJNTc5jA/VSU5r7Nv
         U8UPj5PkIc6uJYZ3LyNzHvc5c+EU0f3AFhPLSHNyG4ecXqoQUDCel3iYt3Ez8WwUlMkF
         41r3rMrIlEwpQRnzou5FX64Ak4a9ycD+NhfzJMIkQ9QS8rUEPQPwqLXR7HAZzdgl1Hiw
         xhQe8+svoYpQDTfkmifnI4A4PgFE0wSXU5uTJMRRKUYRYHUhQdwLl5iA+OK//oHWizXh
         6bOu3V45OCmwqvCDYT30gLKxxFwYkCopNfXNxoTcLSYuKEZNu5KfVFnUnGEcqeahH+Xm
         Lgkw==
X-Gm-Message-State: AOJu0Yz1LcKDeIyDJ/oa2GE+x49q0Wf8Ch+5ZC0h6SJFzqIUkqJ0cjmT
	l7n8kVNggBKSGW9/fb12BHn+rLalp4zO5aaa0ih984hvlqFa4Wl3c0bbPAjmt97KlbHBW2epFUR
	jQZCsw4tEJ4oX86PqScxrC7sHUPE03+Q6QIPHJ9120zM6QfvkfZk=
X-Google-Smtp-Source: AGHT+IFeqrOwZzX8SLndxXXVMne2XSExYOPxX18Y4wOgfN99k+kWSVG5oSFMkFO5NevGtVIsVtpUmeP/VTw0ficLL6w=
X-Received: by 2002:a05:6871:2891:b0:278:5a4:10cc with SMTP id
 586e51a60fabf-286e1283712mr4611985fac.3.1727302732996; Wed, 25 Sep 2024
 15:18:52 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 26 Sep 2024 07:18:17 +0900
Message-ID: <CAODzB9qLv+AEWcHROvnqEndGN7ZNEu22oR29fPRZfWaynYo7pA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Sep 2024 22:19:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16921

Hi!

It's this week's CVE report.

This week reported 1 new CVEs and 1 updated CVEs.

* New CVEs

CVE-2022-48945: media: vivid: fix compose size exceed boundary

Announce: https://lore.kernel.org/linux-cve-announce/2024092346-CVE-2022-48945-90da@gregkh/

Introduced by commit ef834f7 ("[media] vivid: add the video capture
and output parts") in v3.18-rc1.
Fixed in v6.2-rc1.

Fixed status
cip/4.4: [19134263def6981a7a915912512d0e1626413362]
cip/4.4-rt: [19134263def6981a7a915912512d0e1626413362]
cip/4.4-st: [19134263def6981a7a915912512d0e1626413362]
mainline: [94a7ad9283464b75b12516c5512541d467cefcf8]
stable/4.19: [9c7fba9503b826f0c061d136f8f0c9f953ed18b9]
stable/5.10: [f9d19f3a044ca651b0be52a4bf951ffe74259b9f]
stable/5.15: [ab54081a2843aefb837812fac5488cc8f1696142]
stable/5.4: [54f259906039dbfe46c550011409fa16f72370f6]
stable/6.1: [2f558c5208b0f70c8140e08ce09fcc84da48e789]

* Updated CVEs

CVE-2024-23848: A use-after-free bug was found in
drivers/media/cec/core/cec-adap.c

stable/4.19, stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/4.19: [d2cfbc5298add5e0c6cfe8b343f73dfdf01c8b1c,
896dfd4d74f84c854d3a24d889e54a44329d313e]
stable/5.10: [5103090f4e55252cb1b1a6084da53d63434dc24b,
3166b2dffaee89b8c68f55d2c825bb3163a3ea55,
  9f6da5da3d7c73a0daca5c2bc90d3527520ee727,
a0ca5ff242933f7c5ab6e250bfb1b381d090a250]
stable/5.15: [b5da8217c000249c6386ca7e5617a4ad6e959a9d,
f86a3b7ce88bdb6d75be4aecd57a083de545b54b,
  f0266ee4cd03e776c14fe310eed965c5612daa56,
2698f28b1d1e375596c7c07971932d3c7c09e23b]
stable/6.1: [302077d2703b93180f25bfe28debe329bcd91773,
3f56c18a396a0b31d8746fcfea46b3e34e2a1a79,
  6d6ddabcec2720541a3d7649e714209931eed19f,
1e1e7a6ec24bddd4fcdf75480fb5da2854e72955]
stable/6.6: [1af4790bc117579402ffa709794cebb487581016,
89af84e6514aef97266cbf7021fb900a9b832f00,
  cceda163b711ab4d6799223c6c60308a26590558,
8f40b92f54802f6ff80b01f7cedc527d625c7f77]



Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

