Return-Path: <SRS0=rj0f=7V=lists.cip-project.org=bounce+64572+4732+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E05C433E0
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 09:06:44 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9882072F
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 09:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="cSoXGCvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9882072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4732+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HSxDYY4521723xKmqS4UwJrZ; Mon, 08 Jun 2020 02:06:43 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.108])
 by mx.groups.io with SMTP id smtpd.web10.26001.1591607201208637463
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 02:06:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Chprn4dsydSkMulp55KiDaMCXD+2QGT8BF53taksdexxfpKJ60/4WPDlokaZiwV7tpGLz6BWEIw/4YY9JoAa2NmzSETdQrDF+XfOKQuwub1CoELn7lWXM0M+5CZb/T6cGqiOdQJEbgJj5dVEJjTmGA4IT7J8L/jmiDpV7TSLO/NwVnUFpoIZJlsLPJ5Fsqdy335mijwxvZ76nuVyBSkBVt+L267ZiilNp0fdccdBr6aK8u3RPuXvgT5tSpKTAVMAk/iYHGaDiBbN+SNUqQKcmtRVB33Iocu9VicixveZS1XMUtSLgJdV/0QUWQ7OqKOXwBvPqe77JDp/jXdua2IQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDerKj5++IKuhXDqVWL9BDQrYmSv3pMdvvhDBNM4Q0g=;
 b=SA9v1qgi08evFaa3ZYMQifZ6C1YYFCWkG7+czfCWnOT4nZRZbYNb17BMrVHjH23BaObxt/duLr0gScbi/sk/dey7tB7hyFetmdb4QjPZDhMe00RiErGTPuPtWDlrFjyTSyL98PMPuwndrLVxwH4Kp5Q94NPHz2FyxWzPeYd0/w/4y/Y1DtAvW1I+qFSJI/1gmqIQMaeTTJQLPmQuBYh/mzF2rxYBwCe6VQR21Ci6f3+W0rz04/qlX7whgxLVchDFNZprSB8wx2Qk2sVTUbMKTNig3ufJ1JOxZ5AfjajL53tIYbXtBepTXg69HUVZAoDOFy5j+uSIS4HeDbf+wcUIlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB5116.jpnprd01.prod.outlook.com (2603:1096:404:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 09:06:38 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 09:06:38 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] Request Board Owners/Contributors to review kernel config (Due Date: June 25)
Thread-Topic: Request Board Owners/Contributors to review kernel config (Due
 Date:  June 25)
Thread-Index: AdY9dB1bpBTGHhmmQRGSO3W96k7kZw==
Date: Mon, 8 Jun 2020 09:06:38 +0000
Message-ID: 
 <TY2PR01MB497253E7217AED2CA0952E47A0850@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb7fa81f-c461-43c8-81ac-08d80b8b4084
x-ms-traffictypediagnostic: TY2PR01MB5116:
x-microsoft-antispam-prvs: 
 <TY2PR01MB511644CABA707B4873A82BFCA0850@TY2PR01MB5116.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 tBQloUT/8l2vbL62Uk02hCjIGfXmgh3GqBVKBxjYsMndZCxvde09XraHIOUsNtClFEWQL+uyord+e5PsyejkwvRz3+EKcNtypp8+FNe6HEE5WM3MEyDwTXJTY6T8V2QzTpUWAvWXqvi7srfSohvpA6IiyutvfeIwVjhycY7Q0UpOyNJ0RWVZo0+GjKOdztTtst5g4mLoyCBhPJENsdM2EacioJ2HVh1CnCgMEFx2P5SvP1Yq4EQ4Iv+RoSz+hZ9JbK+7jfob5kdGZwKL+s0T9dyCj4QS/TcP1pFmk5Mm1tyZOwZdk6UFYrCJrJrM9a+C
x-ms-exchange-antispam-messagedata: 
 bwvSFTjkW/fIz2ncL+91Zb8t4BC1vjWZ4eBCNO+TeBHLGmmARKSrqhbf3utcoqk/InXbWMEmLokQedJhI+rGbHJe+bs0QDDnZiZvlWYyC83BZ16UP3q9XlAkOyL0A6wyKWp3L5uHhx5dZeMtK9Z8FaTrv+AQdqp3LYcmTt00FbKrbugHk1yddZretsTHbEnX9YkVhjYNSewDZbhIJ32YSppSxMGOigQzpOxyjcr/59L2G8uPJLIz9yqH7OyebJAN5bqTf+CrbX9zIjMAWjLfyuNbBuaLVy/WY2Wph3vHfct75Y9jlrhq3s3VQa3rZ3P9EjoL9iSgwym1qnTC4cScIU7z0TtH0hn1bG/3fh9lzU1hmls3DWg22991M8vtxbC8PzPWFqzqdIsEsXXYaYAJY3ulF81CE5GEIAd8KprnAgr2yaDd3aAHDe+C9heMlpbE1bb73gLeXumtv14hAB60TQY/dsNjiH/7N6klEdgpwHoxSmkV6XQF3HgcifjHUAOZ
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7fa81f-c461-43c8-81ac-08d80b8b4084
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 09:06:38.2901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RocclzxHoXCMiSsFW6lzaWYScnz5rT8fBPs+pbQmkPLoka4t8PhjyMnYS4+ib8cHydhHhlq001uacglkrqcALUO3REfm+V5fnRcXNACdfkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5116
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zZyMRXrbACGpgg61U9YqBZA5x4520388AA=
Content-Type: multipart/mixed; boundary="j4IlGFQ8EtqF4tJGbm80"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591607203;
 bh=+mX7vi2u+pZfJR/WOKfoU8S2xwVfFcx/k60qoltoxCo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=cSoXGCvQifpPXK4s+DPTirB097YHhbm3Kr0Wln/wAoO83vWyTMDO+wKp1Nykfajsgo0
 s1Bz5/GqAOWmloZfDaSrDtgbCxuKtQbDhdrEgl0fEUNtSXF6oNZisIGspu887JwYD9HbL
 891Ql2J6tPdCXPqmSrPJfVIE2jEigjiB7wU=

--j4IlGFQ8EtqF4tJGbm80
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Board Owners/Contributors,

As was announced at the TSC call on May 26th, I would like to ask the follo=
wing request.

### Request
Would like board owners/contributors to review enabled features, and to dis=
able those that are not used.
Some tips for this work are:
- 4.4 is 4 years old. If new deployment with 4.4 is limited (if new users a=
re not expected), features may be limited to those which are currently acti=
ve.
- KVM SVM: SVM is for AMD CPUs only, so it might not actually be used on CI=
P member devices
- XDP (express data path) is for network-centric usage. If devices are not =
for this use case, this can be disabled.

### Due date
I would like to set the due date on June 25th so that some follow-up discus=
sion can be done at the long-hour TSC meeting on June 26th.

### Some background
So far, Kernel Team has focused on the improvement of our own processes and=
 tools.
In addition to them, we think board owners=1B$B!G=1B(B help is important to=
 further optimize Kernel Team activities.

Thanks for your understanding, and if you have any questions, please let me=
 know.

Best regards,
--
M. Kudo

--j4IlGFQ8EtqF4tJGbm80
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4732): https://lists.cip-project.org/g/cip-dev/message=
/4732
Mute This Topic: https://lists.cip-project.org/mt/74748203/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--j4IlGFQ8EtqF4tJGbm80--
