Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EBAC54EE9
	for <webhook@archiver.kernel.org>; Tue, 20 Sep 2022 10:16:37 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.74])
 by mx.groups.io with SMTP id smtpd.web11.10127.1663668995471220660
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Sep 2022 03:16:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wwoRTmJo;
 spf=pass (domain: siemens.com, ip: 40.107.8.74,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdPzSq2P8J5KWZt6uDqS/xiAm5KTUA0UDMsJyLr8dw7a9AJ8xE0Vqvq97m7nac7x2dKJqFRBAsnaaPE6snjsZZF66/ezph9PmoTn1Gowtc3faYwBIlIvpYU1vZ3sga5VgJjFIYg4rJx0tUy6kUTo4HvTgw8WMFfcvlXQOZC4q5KkB+Iv4o8h1CRYR/yUpYGlQJJZSS4oYXCCFnX4durhs+PFz3Okb5hWc3ZfEHGirWN/BgrR0kamQmBY8581m1HPzQfDIpKwVmMRiVl1BMYFSg7VF3+4tSGWTgCD5IkJNf02Nvt+YBmCBqOqgpq4G6CTkCqsceVXc8svPYXitavtTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piKm0RdD91c8fpHibTxk8WsQAlDloBmfYqih4wmwJM4=;
 b=JOVnq7Dh95HWeAf3XRTQkO2wihcTGJa2sKPVu1hD4Rds35fFIAt/T+2TAC7C8b22K4KNqoP9Our/zR04aiBfMyZt1pEjK7fx+eFgac089nf9/lz10JRwiXMhuEJERy3mVFPvVCRytdtIw5fRLtPn2rye25utIxS9j5EuyythKaqH429UzuLi/1t+v+K17/W8HI4GCWXQvu0SaGi2aBZicC5t66aggpqBcSMfUxmspLftk/uIOVtVFn2d3igOeFGUBNzqLxVb0tgY1GahOL2H9euL8VjPv5fA22X9UI47P5akqSXGUvY9Y3ge4/fwL3qKpkaCJVx3CJyBDbMbSvWY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piKm0RdD91c8fpHibTxk8WsQAlDloBmfYqih4wmwJM4=;
 b=wwoRTmJoqUbuVJEveeTF6zR48eP344h2jZi45KE2u8GM3MFJua0HqYDuE4Wlsq0NlAfrBwKFuJhtU5UuHolIQMCnvVlQ3UErjelbLheVj2adQgNnZqM5WW7kz5Y9rozXEJx6O1Iz99ULrKCfAR1SwAQ2U+lO1FEzy+yeaoMq5xZJlgAOVydzCPCzWsohb+hwzj+Jue//3ZqQ18jDx5NtsHvtoZce2SQUyaortP2ErX622HTfNmAeDdxpOP3wh8mRj7LPk9TzQYWxcKsIs9Anbm0Kls+qM/VvOrnyfgTZADbOsJPCqB7d1mv2oNt6VBoMonTvLGepeTRhHJygsTUZiQ==
Received: from AS8PR07CA0002.eurprd07.prod.outlook.com (2603:10a6:20b:451::31)
 by DB9PR10MB5883.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:397::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 10:16:32 +0000
Received: from VE1EUR01FT069.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:451:cafe::e6) by AS8PR07CA0002.outlook.office365.com
 (2603:10a6:20b:451::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Tue, 20 Sep 2022 10:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT069.mail.protection.outlook.com (10.152.3.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 10:16:30 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 20 Sep 2022 12:16:30 +0200
Received: from [139.21.17.42] (139.21.17.42) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Tue, 20 Sep
 2022 12:16:29 +0200
Message-ID: <cddf20b2-2763-8f2b-f313-54a95f32b15e@siemens.com>
Date: Tue, 20 Sep 2022 12:16:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [isar-cip-core v2] README.swupdate.md: Add steps to verify
 SWUpdate on BBB
Content-Language: en-US
To: <Shivanand.Kunijadar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
References: <d98e57e9-2219-6e09-582c-b465e9295193@siemens.com>
 <20220916114330.18443-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220916114330.18443-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.17.42]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.320700-8.000000
X-TMASE-MatchedRID: ObgwaKFsELDO278aZjZxZ8c50LsMZjCp/k5m7D0YTS/x5KZMlKYS/ReK
	/B+WKxKs9/tYry8FJ+9fjqIZlM+knq3aC25avUuaplCaRSPAyU0PBdAcQklBEq6pwuq7tDp2giz
	NKnxrsXLfc2Xd6VJ+yq2LobuNU2ekROogZf1QZqaJFgYp6ABGFIHDqMX5R2gd5wXI1oONVuA/pO
	SL72dTfxzSdtho/k/DxM9DM4OIRzby66m4pHtXNS6zCHyQ4joSgikKe+oTH2HGL//8mlodAwEPJ
	rYlsf/6n7jOJQ+rgvHgSPui8LpneYdsCtwBMNH88XNfbIb5rF/eIcxASzqxximUeaaPsnOCPf2+
	tfEqWx1PMAT3j0wZe4H2LTeD30MlK+fbv4M7+TC1M6vEQZCbhnDWCEZXvYIHngIgpj8eDcC063W
	h9WVqgtQdB5NUNSsi1GcRAJRT6POOhzOa6g8KrRaw857XU3bLFVk8OBTs1TxHUo26ciHSxjEyBn
	vNlMBr7MaQtiPKIbw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.320700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 069046174B6A34078D21C0C95DA050E4A97D6D7BA36F47FA129312347409B4302000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT069:EE_|DB9PR10MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 395c1192-89f9-4602-243d-08da9af12fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3Qv6I2QK3p2bLAByCo+aCGvop48RauUGS9YLHWC+mxbcWCXQ4Ca+pLecgDcWwXs2GlWDWND413wo5H1LUaHUKqXQpVy/vVqGhMMvojAUiTlu9aaan6FuK0i4aG/cE6yjxstsrbx2VNLtRUxONNlQXJsxpPTVhYAX4g/bkiPSmvkIDBEu9HgGdMklkHv2chmcYy4aqc1nQmOuX5jWRD29uqOI6UXRmVnQNY2xmV40am9/3e7IN4nNH6UO6JJR27WWR3zF3M7TaM+ABx2MxP9va2ZBXU4pmvUgDRhxzIjdW+4bArGLlNyD2FjNVu1yYB07SQVDK3ulZU7Bgy7qdTHIGgVDwqTdA1+sF2bTRqFft6N03LamGBuqfT9EOfYw1LekAGd0luow3OAFOdVJ2M1e1yFR7Jv8KW1Wb4a+E0ZUTW0C93y2kV7ZNySyy33EZ1mVn0QulHaRDHxXKApFfgi9M6/fhS3BkrNOXcNHHvFxvFUL80E6V7OzXd0Cdl8XSNrPaFjxsPTeoARlX/OetcuHT/b6VxEiUb+6Xst/J4Dg6TmyjsRFfr2uOAWHRrD1sYuZGTokWWyiI63a4pWLfdBa1bCzguouo02wHrvh1PJ+dmMehv5onEdVLUAmxT6a1qEDyfuiYBWX65SYSfEgiHtFDn8KC/RxhHS3SFSIkRAXeviZxc0qU//l+yZJ9bO2R1BBjNFBHp1vG0Oy/jeY7FXbS/w8dnQTXlO3KVM/8ymrDECInIiE1UB+lSXFeRBWo0EpfKipQlHKiES1LF1+7QwJxtfVpn3oq8nDLh1UVrZOq+BYuKz7GaaO7Xd2MakXuOCIlB18HOsmsDAzGn1B3Xlufjx5fVoe+X7ACsdZnZpqgmE=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(2906002)(82960400001)(5660300002)(82740400003)(8936002)(478600001)(15650500001)(54906003)(6706004)(31696002)(40460700003)(316002)(86362001)(16576012)(8676002)(4326008)(110136005)(70206006)(70586007)(81166007)(356005)(40480700001)(41300700001)(36756003)(31686004)(956004)(83380400001)(2616005)(82310400005)(44832011)(186003)(16526019)(336012)(47076005)(36860700001)(53546011)(26005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 10:16:30.5883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 395c1192-89f9-4602-243d-08da9af12fd3
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT069.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5883
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Sep 2022 10:16:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9524

On 16.09.22 13:43, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> Most of the steps are similar for both qemu-amd64 and BBB targets.
> Add reference link wherever required instead of repeating steps.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  doc/README.swupdate.md | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index 1b242a2..9be3498 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -32,6 +32,8 @@ Copy `cip-core-image-cip-core-bullseye-qemu-amd64.swu` file from `tmp` folder in
>  host$ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@localhost:
>  ```
>  
> +## SWUpdate verification
> +
>  Check which partition is booted, e.g. with lsblk:
>  ```
>  root@demo:~# lsblk
> @@ -215,3 +217,26 @@ user variables:
>  
>  
>  ```
> +
> +# Building and testing the CIP Core image for BBB
> +
> +Follow the steps mentioned in the section [Building and testing the CIP Core image](README.swupdate.md#building-and-testing-the-cip-core-image) for creating images and .swu files.
> +- Replace qemu-amd64.yml kas file with BBB board specific file i.e bbb.yml
> +- .swu file will be generated in the following folder build/tmp/deploy/images/bbb/
> +
> +Flash the BeagleBone Black image into SDcard
> +```
> +host$ dd if=build/tmp/deploy/images/bbb/cip-core-image-cip-core-bullseye-bbb.wic \
> +   of=/dev/<medium-device> bs=1M status=progress
> +```
> +
> +After flashing the BBB image into SD card, mount the SD card on host PC and copy .swu file directly to root partition like below.

This is missing a step: Build a different image configuration, e.g.
switching to the RT kernel. Otherwise, you are now suggesting to flash
the same SWU on the disk as you write as full image, and we know that
this is broken (plus we have no error detection for that yet).

Jan

> +
> +```
> +host$ sudo cp tmp/cip-core-image-cip-core-bullseye-bbb.swu /<mnt>/home/root/
> +```
> +
> +Connect a serial port cable between host PC and BBB.
> +Insert SD card to BBB, hold S2 button while applying power supply to BBB.
> +
> +For verifying swupdate on BBB use the same steps as mentioned in above [SWUpdate Verification](README.swupdate.md#swupdate-verification).

-- 
Siemens AG, Technology
Competence Center Embedded Linux


