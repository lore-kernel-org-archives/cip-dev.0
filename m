Return-Path: <SRS0=ISXm=7W=lists.cip-project.org=bounce+64572+4788+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0C4C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 10:00:58 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC46207C3
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 10:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="E9yXgPo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC46207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4788+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ggpiYY4521723xkhMyLexqC8; Tue, 09 Jun 2020 03:00:57 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web11.3882.1591696855951649243
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Jun 2020 03:00:56 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 059A0rtC028530
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 9 Jun 2020 12:00:53 +0200
X-Received: from [139.22.36.66] ([139.22.36.66])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 059A0qc2000456
	for <cip-dev@lists.cip-project.org>; Tue, 9 Jun 2020 12:00:53 +0200
To: cip-dev <cip-dev@lists.cip-project.org>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] isar-cip-core and cip-kernel-config
Message-ID: <e9ae3b47-7f38-0da3-b90c-b0b4dbdf1eae@siemens.com>
Date: Tue, 9 Jun 2020 12:00:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: CRIF90rX2txRN8etffbSmsBFx4520388AA=
Content-Type: multipart/mixed; boundary="eUwQAaGJ8rxsa2YR6ymt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591696857;
 bh=QnjZm8Wws39Mo1mL391uuETvjbLPLifJYb/puXUjlnE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=E9yXgPo5Sh+y4Wz/o5Jo9bNhD3Qbt1Uc+yjhIGy+iXdYsV6RsBpNThhVGleA+hyTbGH
 L+3jUe1SaEAQK0kgqpPcZFoChQmJygPPfR9VGvO511QLddZpYlDUT/Xz4S0IiXD3ZPBw4
 vbFnEKUL5XSc8xJl6ot0jBXDWcOLmxEQNwY=

--eUwQAaGJ8rxsa2YR6ymt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi all,

a quick follow-up from our cip-core meeting today:

isar-cip-core is already able to pull configs from cip-kernel-config. It
does so for all machines where USE_CIP_KERNEL_CONFIG = "1", ie.
hihope-rzg2m, iwg20m and simatic-ipc227e. So we "only" need to check the
other targets and see how they can be migrated.

And we should remove the old defconfigs from isar-cip-core then (some
could already go).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--eUwQAaGJ8rxsa2YR6ymt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4788): https://lists.cip-project.org/g/cip-dev/message=
/4788
Mute This Topic: https://lists.cip-project.org/mt/74770939/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--eUwQAaGJ8rxsa2YR6ymt--
