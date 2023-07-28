Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B490EC04E69
	for <webhook@archiver.kernel.org>; Fri, 28 Jul 2023 14:33:57 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.47])
 by mx.groups.io with SMTP id smtpd.web10.33541.1690554831169870021
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Jul 2023 07:33:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TMWLgusa;
 spf=pass (domain: siemens.com, ip: 40.107.13.47, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7Ykwbtc+6z8T3G4/uzfX98J87tcwlRXQ8qTFyGvtAAbpMJ1PRgbZByioEUdjXsnVRfgkO0bl0yED2qlPe4B4GRMsoYvSM4N7KTPz17m+gg2rkPT4paI+ua7hGo7AtX8M5yf5eGe/vVxHIL0iRcfo2j+0cSdwZC7/mAx9ZnK/LJvzLCrfWqqd6cOwG7AeOqeciPyzR5UaiOJpxKhkxM7Px2SnD21NjmOypTO0RoN84Ab98HzyF1XUy28/heueCBriLgSK8jpi1fRnTKILEgkyvQcocyHHGWYv2nOC98izX3bRiHI1mPtWZbPxC71buoHOkRoYGWjCHBxMot2Z4rJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pH34JxZTKpx0KBsI6L9ANHK8pNvV0CiA4QdsdqVS6/s=;
 b=MqMRZ34s2O3xXSLtjyWrkf3/lP/lGF/IwoCfnF/mB4kjqLSJMzg5T3IHEsLdC2akvxkqPsnxWE1cBX5Gvgr1LTNqMYGnxf/9vgteIgxM32AVZW49mynboMloQrhiddql+WfrGV+j7yYj1+H1DPWaXG8JykmbfAJ8ZtqlgjysWaX6cz1lvYUsWiGQ3yRUdqoK32Qnpie+8BOdFt6yP937x9fwYrFB6umAmcl0bauitR6hJSb9g4L0s2XbJqICZwTWWM3oOnd0U+4lM66pDRn+cD06FEXPpRqtyGqMelg7HmevbzYWxTu2VsXOIG7l+vIajbXOaL/7nzfVemSv2PqwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pH34JxZTKpx0KBsI6L9ANHK8pNvV0CiA4QdsdqVS6/s=;
 b=TMWLgusa+T5SsUfCO0lxy332b5Iay7xmX8EksRfHXkCLxRMmrEzLevsABXKwcg01YeOmLPe4MSF+evqbDpJYXoTwNXPhJop0LHjK/p4/KCz7SL3Hj7F0Ulnbom4BDvU6mkOhrppiEcynl/7JYrEpkqsmf39MjMwcvVhiSxCPzOw1XYew+dOsrkbfL4ttcNDUn0j3hGIg7TXp4um3gF79Xtp3dgsK18jQKCkptOuu+5BsuTOmR9rZcMdcA0fGvoCCGW6HC5aMhT7cHUSAjNheTYSlpCmprWkd6CT0Bw/dW7Es0YTgYRmtT5TarNaKRZJIR/9NtB8SyIjXp16gcSei4g==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by VI1PR10MB3151.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 14:33:49 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b214:c3bf:bdd4:fd7a]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b214:c3bf:bdd4:fd7a%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 14:33:49 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Storm, Christian"
	<christian.storm@siemens.com>, "Adler, Michael" <michael.adler@siemens.com>,
	"Sudler, Simon" <simon.sudler@siemens.com>, "Koch, Stefan"
	<stefan-koch@siemens.com>
Subject: [isar-cip-core][PATCH 2/4] initramfs-crypt-hook: Check and repair
 filesystem to prevent resize2fs failure
Thread-Topic: [isar-cip-core][PATCH 2/4] initramfs-crypt-hook: Check and
 repair filesystem to prevent resize2fs failure
Thread-Index: AQHZwWCFfF8H8bWo9Um6DxiEYrEscw==
Date: Fri, 28 Jul 2023 14:33:48 +0000
Message-ID: <20230728143320.3891194-3-stefan-koch@siemens.com>
References: <20230728143320.3891194-1-stefan-koch@siemens.com>
In-Reply-To: <20230728143320.3891194-1-stefan-koch@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.39.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|VI1PR10MB3151:EE_
x-ms-office365-filtering-correlation-id: 99ec6704-d2ec-4d3e-fd85-08db8f77a848
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 HaEl00rxUShjSzPh/GYViJg+KN+DTE2qDbb8Z2QON7Ai2iy2AIqH+Hu3qEiVK/GlwL174DvysGIXkAsvICg2Gj9xp/wT0838zKg+U1u26zW4dt7FHAmoljcV30wCMgHml5F9ixYiqbg2/nN2rXI6p1/R/OT+jQsUVS1lBbSlGOsRLhk53EeRu+EqrozYzd48HUoGrJ0OrgQvPlZWElZdnzEhgiHbZGZ9dwwGdOGhdJ0JxzZRvAD2djHyHsfaXoysQRwdicPkq3GUQAFUHUMBJC8w835rUxb6PS32tsAw8Kr7pX/gKL6IZMP759a8hR2hEovVWZX6mn5ZKdhtwzTndi6nCL7cCXQQbDapuBv3qekb/yXrWZaI8wYMnGlUXHKWLiglqISm5jcMTgEexdTIUz1s+tPPwQEHct25IRFj0BiZd1SVuNXSM9WXfjs1jD/zIE/vg584KqjXifqLy1zWlYVKEtkjRcX+LV/cnovKB34/dO9gDZze7sP4gAZvFvAOdxeo9NxWEjle2NBYNqBdJMtp45OsmHt6H85wzGwKi/Ud6rfwQfP/xVvaUNQa+61rq15jWzGsBQqgC+Hy38xLeeuX9bhDR3ZKvRn9R9ioY723+DWSkWD2i3NAUp39yE8G
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(1076003)(82960400001)(26005)(6506007)(478600001)(54906003)(186003)(107886003)(71200400001)(122000001)(6486002)(64756008)(66476007)(66446008)(4326008)(6916009)(2616005)(83380400001)(6512007)(38100700002)(66556008)(91956017)(76116006)(66946007)(5660300002)(41300700001)(4744005)(38070700005)(316002)(2906002)(8936002)(8676002)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?LKjWrK5YSJ7/ExSHpasN94uowrTbhMS/TptcW79ive9ZRJDRf2AJ35vuWU?=
 =?iso-8859-1?Q?FFao2hA95jExstpOTqYgwloCXQ8rcxFbaQPLem/Pe60x89VFuRibprTSWF?=
 =?iso-8859-1?Q?3NoAf0TDC+509TKdRE0Vv39b7xSP6XE6jyAnS03vCgj4K7YcAZ0WR17dM7?=
 =?iso-8859-1?Q?UMcflcV82VzsFMRbjG5c/FZo4PXE2Hp8jrcj+TFNN2SnRR0hQDetAzoxjU?=
 =?iso-8859-1?Q?RmJNJWOhW6QEdxxADuEPQfQOzjjSPysTE5ZMBV+zZR0fqZLLImw1bscrlp?=
 =?iso-8859-1?Q?JRip3MkUjOIFyNXW2eMMUJOCE/labKi4XBVcoGoZo9buP9v2dcmp26L3/Z?=
 =?iso-8859-1?Q?OjmTiIb61U8YylNyzggetr1/lmwglKy50wq7A8HoovgecFZIX9WXZC0Wib?=
 =?iso-8859-1?Q?s0no3/eijfmiCtUPtCFow/X4ppWJY7zQHh+f90wWJ/4vQ+15qHLJsQzXMc?=
 =?iso-8859-1?Q?g9kl6BplIANGLa+UTUpJAd43ET5rhI/h6lOb7hP4tA4mHUtPdTk5+GYW13?=
 =?iso-8859-1?Q?JQzDjmDnMTAFidvqirS/6FgloNRuzQyczlavcDluA/E12mYQQmLH5BWHGY?=
 =?iso-8859-1?Q?/m+GLWnRuEUT7BtqTlTlMZMWIPEnEuAN0ohQ7Ad/IcOroJXz7L8iLm/pP3?=
 =?iso-8859-1?Q?BcqysxFwus9lMdt+yjG6nfoAYBbGXkToSjHfyyHpgLCBnJ32jqUjZPvyVV?=
 =?iso-8859-1?Q?eyswsWTUJlsbnrw2zEVXGGZJ4DIAd/s1Q9K2SsiIkfFue4r9blvfL35RB2?=
 =?iso-8859-1?Q?T7/CV6enjQ01Y3jSrLAIaLIaJuS2gshIAFsjfJPsCQ8ClqaqIDzPNBPM9Y?=
 =?iso-8859-1?Q?GFxcvO6LlCT1AlmBA5k6C8Gyzb+QzvzBiuZ/7xGm5wi1zWbQb0rGRrx1sy?=
 =?iso-8859-1?Q?KYhLNkA5KN3ZkzvG8+p4Z6UYvn8gGqpb8NRiitg5zVKXR24zbz6Fg2K5qf?=
 =?iso-8859-1?Q?gAvbeghRz3xeESKgvM66iJ0oiAajL6YYlQJHPwc1nTX2rJZbL84daEAu4e?=
 =?iso-8859-1?Q?Do3vhtFge7mmOvmeBpcqwSN6Rt993aiqAY/lfLjPeSZJu2xHYjYvtSYIBm?=
 =?iso-8859-1?Q?G3qJiPhdEvSrnmUc1TGKD+Mqlwvr8B8Xo59nCEG2cYVdZaEL8sUhrYtF3D?=
 =?iso-8859-1?Q?JjDR6C9A0Y72+w1y6ijqsxoYZlw+5A7H7YWBWlNP5sVtT8y30+p1sJPTVe?=
 =?iso-8859-1?Q?VDWN3B7uXzoch9Alucd9tEr9/eHsteBHCy/B3uoqK/geekfeFHIq92iLVI?=
 =?iso-8859-1?Q?4Gq5Hwhdc3s6K6BXF95yYy8fg806bdIGEyJalbBROzXUDihNWRaEgv9+Yn?=
 =?iso-8859-1?Q?q9mz2/tFD4ILFayk5KgktczU2s8Lznm/1uKWbOg6qOR9wE7vU8d1guexsY?=
 =?iso-8859-1?Q?yQZTznpPl8wXloHITD90TLiAsBT7TDIGQ2MKJmjyFSpHHyMTjM6djWPsfx?=
 =?iso-8859-1?Q?Yzjcr4Rv6qgAMeH3mIEjHXoivjfffpa/uHDs68eS9ame5pdKBQnA5+ENvC?=
 =?iso-8859-1?Q?9NDQKXYQu84SDVfZUe4jvH9i4590y8N6nRoquIv/H6cdwgyu0GruGOimLN?=
 =?iso-8859-1?Q?brEm+P8pgFtJO7YxvkwX/Km3286buswTzKGN/IZ5tuGq5Z+4B6RXkyAOxQ?=
 =?iso-8859-1?Q?0iaLPrAKzSxPzw6Op9Q1ZME45aJFoqQsOXKiBa7NhiNu2AMlE3uzsFQA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ec6704-d2ec-4d3e-fd85-08db8f77a848
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 14:33:48.9712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SlOuWiikE2fmsr9GuOdi5e6CRTQrbxhwgUXMr0WNzGyBXPCkzFP1/8mmsjzxBA/VkC7zPadU4X7FpIrKbwh8vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3151
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Jul 2023 14:33:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12519

This checks and repairs the filesystem first to ensure that
resize2fs will succeed.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.systemd.script  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_part=
ition.systemd.script
index 83c3238..b32b2f2 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
@@ -87,6 +87,7 @@ reencrypt_existing_partition() {
 	reduced_size=3D"$(expr "$part_size_blocks" - 65536 )"
 	reduced_size_in_byte=3D"$(expr "$reduced_size" \* 512)"
 	reduced_size_in_kb=3D"$(expr "$reduced_size_in_byte" / 1024)K"
+	e2fsck -y -f "$1"
 	if ! resize2fs "$1" "${reduced_size_in_kb}"; then
 		panic "reencryption of filesystem $1 cannot continue!"
 	fi
--=20
2.39.2

