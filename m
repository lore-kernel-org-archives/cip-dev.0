Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D97C47DD9
	for <webhook@archiver.kernel.org>; Sun, 25 Feb 2024 23:27:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.9370.1708903615944649214
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Feb 2024 15:26:56 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 41PNQZcr3643967; Mon, 26 Feb 2024 08:26:36 +0900
X-Iguazu-Qid: 2yAayDBj4hflQpEcNT
X-Iguazu-QSIG: v=2; s=0; t=1708903595; q=2yAayDBj4hflQpEcNT; m=vI+DnydcKOYl+0/M3sJ8BubkVLXgQDGSUXwuhn/eSTc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 41PNQW192466164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 26 Feb 2024 08:26:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcdGlXa3M2kZv22xnyvjPbHfb5YyZMvkZg7vMRZvfvQQddk4oPaHav3VCJRO0GJpgFW+fN/h12LDPaHAIre49wYByuI612MizhfX848HlcLtkeSXme+FB6WHkqytbKRY7JQcwZ2VJX6hCiPa3XGxn+xau44ybzYPL6R4qdy7PaYYLfBBkLxDgN+7OJlnx4+UyehmoH3FFzOykgQ6i3J499JQE0lWvuXP9jqUU+oORadoOhOJjeh9oBJNoeprwC3ovf6hQxFg2RHZp30pcbpIVm2O1tzjdzQkgWYKUWH16c0GS/RdM3KnaXuIVqcVFiGU2l4iu3qi3PU9n3baiQFPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8zbLfnP0WynIh3M4SJb1NQu/oz+cW6e0pbv+oYcwiU=;
 b=EdPKpPauTKP2jABBw5BUMlvDTX0bXPxF2LUR3O5nT21LF97mP1tbO40wPNelaT+iZeYkycs+o+ZtQEKGoI8BzroP7c9pFR8fKZoOixGy5lOmIfxs53esi4TwJss2nkmb7/Fjz1yXS99TA60WymFBXqIbhxQYX8m3SieLmrBhqbQaMsAOu/zTlorWAV+LL86Va/FfXJ9+H3Kg85Vaprh2cqdl/aZbDbHAiZg7DJ5yWEMWXbtkCT9cus/5XqGNtXigaXJJlIJ//qhUSZuf7v56i8TTwje7mIKJh1aAyGx3bALYNNRiEJzE0lA4GU/6HHYBCl7VpTLQJVRbJwJLCgQKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <Chris.Paterson2@renesas.com>,
        <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release and and v6.1.78-cip15
Thread-Topic: [ANNOUNCE] Release and and v6.1.78-cip15
Thread-Index: AdpoQf4KVYZKcHo4TqmVXGd1zVw9KA==
Date: Sun, 25 Feb 2024 23:26:30 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638897353A24F4F48F8E0819925B2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB8488:EE_
x-ms-office365-filtering-correlation-id: 17ccc333-aded-48b7-6089-08dc36593271
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 jryw5BFWXYufEP5cQeOB85o1Fie2Z0Ywy2V23TIReBOQMva0VZoiHKZgmND/QrHoBrjCDDCsaXQLlgbYTpd7mrJmigI2ow3dVOdJwecqOuYXZo5iS52731KYSkNMxlKxm0XxtFQI+1OslUMaSKl27u3bDOBAaYXfGshuO2pKY2rp9ngLPzLoeY2JFKlWSTU3RZti27s05gRO6OIoX6u4ZlZA4Bji1kEI+Q16wwzIeFLFDo/A75G3zUOJAdl7sDr3C1G56csyPN0K0LvymvdjbiNfs9/8EAc+hwbuAccHIiPox7nfoWZ6Qko4i1FueK+94TE98RFgvwt50ft0BTWw3iH8DziSJ+YdWwuC3y1WAmL/FWUtffZ2UIDosy5J4yDNTJPbIRyYerGCGVO3J1qrU7/mUFsZpNHCYEy6wt+C1ANVX8F6DEPtF6hGO6AsO5beC7gO6QDVQUWxngQtgZB1rDjfDVx5WWFL4kWIiN3djmR8FEKDw50bQaDbGWVRpgu8uYcyZWa+EPZTJpxEOqYWI/xTjTYuT4FFUCfqOfFvHx0O5G3VTTD1mSx70Qekqp30ZCEgHjXOCPearySk61Ox3WxLm/j69JapxjF1VyVcq6DjooUUhlLcrUkzHPYLWiYYjAQMCpNs1MksV7sljr7VdW49brq9fa5jjRN6F4lfEcxl/Ym99WBk2WX01KoDSPP8IRVmBzyrDxDPMjnC5E/uJ8D7owmKf5sAAc7btyRffMs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?K2F5OTFkM1k3UUtPaElraXQ0bHhyVStBelFmaWh6L3FzYlhpbDFDaEpw?=
 =?iso-2022-jp?B?UFFiSmdiaE5CcmQ2N28vc0tPZVhnTkQrc2JhbVU1L1ZYSjM3djBKSWVO?=
 =?iso-2022-jp?B?cExIY1pYQlRHRzhCS01tdC8yVXJIVk5pWFN2a3FOOU8xQnRWYmdYQ2JF?=
 =?iso-2022-jp?B?eU5RaUVFQTNsaTdRZ1NRTHhLQ0FkcHV3M1pqdHRxZU1oeC9uNXpiY0xS?=
 =?iso-2022-jp?B?VVdsaG1CV0lsV1ZsU0U3eWNKelVIcDhBZ2cvbXZxRm52ZlBLVEtMekdx?=
 =?iso-2022-jp?B?aDhBcjJBbENMMUhSR0owWFAvWXNYa0l1SjQzRXgyYXdySG5ENEpqWFlM?=
 =?iso-2022-jp?B?RVg0eGM0ZHpudFdTekFIa1BLOVVDVHFaOVZRZW0wd2ZPV3U1MXB1WGFU?=
 =?iso-2022-jp?B?UzVKREptZHRMWXRxaDd1ZjlxYVBXNnBYWUxQZU54a2QzSmZXK0l3akZI?=
 =?iso-2022-jp?B?YXlWV3FMNDVyWThNdXEzSmRNbVdTdHpLaGYwOEJXVEtIMzFkZDhNK0VX?=
 =?iso-2022-jp?B?T3RNaFBUTWV0OWpRWjJHNGV2WDdONWN1Z2tOR2VYUzA1eXYwUElWTFhQ?=
 =?iso-2022-jp?B?NTJPak8xakJuYTQ5NzMzS1M4NnB6TFY3ZEMxdDlzMmFLNXNEdFNEZ1pM?=
 =?iso-2022-jp?B?M0xXSkJxcENxanA0RW5iMXF3anpzQ2pSbUdvdDZpZEtVdkVWSTU4NFNk?=
 =?iso-2022-jp?B?dTc5aEg5OS9ISWF5NnR6SEFWZnZobDhCbkFzVU8ybWp3RmVRY2o5Sndu?=
 =?iso-2022-jp?B?WUp2WGg4ZjIycGFJUFV0NHNsSWFNT0tBWEV1VGowUlZCRGNRZElLeFRw?=
 =?iso-2022-jp?B?amwyRnBjVVpKV2hkdy9rRDlZOVhESUc5ME40dFpxRUk0d0R1KzlNSXp5?=
 =?iso-2022-jp?B?ZXo1WW9CVXY4elBoU2h0UGxJWjhwdXJiNWM0WjRPbWxoaTZuLzlHWEti?=
 =?iso-2022-jp?B?bWZGR2tUYVYzNHRpekFhK3pVZjBkZitpaUdWZFBxaTRPd0ZhT2ZnNDAx?=
 =?iso-2022-jp?B?a1lNc2RQdHF4U1VpeEhGbjBub0RUNmtUSHRUQXNDUVNMT1F5Q3hCVVUx?=
 =?iso-2022-jp?B?M2tYcFFaem53OEprajVlZGlSdENxSFpQVkxCVC9JN1hMc09hbU5EOW91?=
 =?iso-2022-jp?B?dy9nNnZCa2NDRklLMXUwdVZqbFlOSGNqajQ3SnhkQzNxak1jV0lKUXZt?=
 =?iso-2022-jp?B?dVU0MkNtYy9ET3RMUlpka0Jsb0VvQUU5OFFkaWpvdk1vWUdtaTc1UGgv?=
 =?iso-2022-jp?B?bDA5dHg2Qk9pYlRJYmtJRDZDdHdNSzA4REh6RWxabVhtZUF5dVU5d1o5?=
 =?iso-2022-jp?B?RHlvZllDYkl5MEVGeTdDN1VTMEZQR1ZnRHI1K3lpSWVlNVNzMDBkeE1S?=
 =?iso-2022-jp?B?Q3hrOHJnOWQ2R2xHYzFibTFsRnExeDZ2OEVLNllUZDh4bUJtQSttS2xz?=
 =?iso-2022-jp?B?WEpLVzNTWTNmVUFVVVZhYXpXWGo4aXRHUGI0dTJoNzdXZDZTSDB6dmVj?=
 =?iso-2022-jp?B?SDYrSXhrSnZvRFZvRWR1dG1TdURTY0hVM2g0a3VmSEJEeVU0TWhJK3ZL?=
 =?iso-2022-jp?B?M05COW5BRlRJY2lZckIyQ25kSWRWU1RpZ2lxblFFcjhlcUFOU2s5TUJW?=
 =?iso-2022-jp?B?b1BmQW5iNnJackpISVkyTDE5Ym5SZitXUXUyN05oeHdvUlVEcDNKRUhs?=
 =?iso-2022-jp?B?VklJZTQwWFZuUTIrYVpHWHN1VllkOHV0Vk9kMkpudFRoVjFMaXZoY3VN?=
 =?iso-2022-jp?B?ZHIwb1ZGS0RtclErRHh3MGZ2a3o0cG8vUTRzM2FWcW1HVEVpQ1QzVDZa?=
 =?iso-2022-jp?B?VkdaNFdua2hKTks1ZDdsMXZBTGwzdldnajlFYXAwMnFNOE0vMWlZQjdp?=
 =?iso-2022-jp?B?SnR2RkNlOHU2STRDdFA4QU1IQ1Qwcmtub0NGbmlPalJrV2ZqaHRESGZh?=
 =?iso-2022-jp?B?YVlwWG5lckhsWU83RzZaaVkrcDB2YmRVZjh0YWZtWmIrUzJiY0pKZnRu?=
 =?iso-2022-jp?B?SlZ1N3p0UFhGaHhpVjc3K1lJYnZtQ21kWklCNTJVOTRzVzhCdmtjTEpn?=
 =?iso-2022-jp?B?UWV2d0dxUm1DVGZhQ0dsZFdhUDB6ajNCejJpandZRVI5WUtoMHNmMWcw?=
 =?iso-2022-jp?B?SVRpaWRFYUJhZklWbDJIcTljTlVHU0t4dkE4KzJxbkNkamx3OWlNS3hm?=
 =?iso-2022-jp?B?dkpmK0dJNXdXZ3kxVjFFZHRMaHJJc1dSRE9qMStlOVVUTWFpYmptMHYr?=
 =?iso-2022-jp?B?bEVRUTdlOVRrNy9BajdJbWFpcHAvb0hVOG05WmE1K3ZwMEplY2hBWTY1?=
 =?iso-2022-jp?B?WkRqbDg5WEU0R2ZCS2dGSmd3T1ZQUWNsbEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ccc333-aded-48b7-6089-08dc36593271
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2024 23:26:30.5768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xdu/Z2NlPgf/QqIUCPlZXFuAzby+ZQ9c0yb4MBB09/Wl6wLk7BgVTetsIFIXr1pX6W3sa5YobCURBt2t78dierUmkqtWB6bejyBY9ArfOyd8P7LJTUIwMD5ZOIsZg5Zv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8488
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 25 Feb 2024 23:27:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15082

Hi,

CIP kernel team has released Linux kernel v6.1.78-cip15.
The linux-6.1.y-cip tree has been updated base version from v6.1.75 to v6.1=
.78.
And this release adds device versaclock3 fixes for Renesas ARM SoCs.

You can get this release via the git tree at:

  v6.1.78-cip15:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      8e0cf035f64a98ea0d7ed2527a547f39866c37ba
    Fixed CVEs:
      CVE-2024-26581: netfilter: nft_set_rbtree: skip end interval element =
from gc
      CVE-2024-0340: vhost: use kzalloc() instead of kmalloc() followed by =
memset()
      CVE-2024-1086: netfilter: nf_tables: reject QUEUE/DROP verdict parame=
ters
      CVE-2024-23849: net/rds: Fix UBSAN: array-index-out-of-bounds in rds_=
cmsg_recv
    added commits:
      CIP: Bump version suffix to -cip15 after merge from stable
      clk: versaclock3: Drop ret variable
      clk: versaclock3: Add missing space between ')' and '{'
      clk: versaclock3: Use u8 return type for get_parent() callback
      clk: versaclock3: Avoid unnecessary padding
      clk: versaclock3: Update vc3_get_div() to avoid divide by zero
      arm64: defconfig: Enable Renesas VersaClock 3 clock generator config

Best regards,
   Nobuhiro


