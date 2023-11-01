Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388DAC4332F
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 17:23:09 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.51])
 by mx.groups.io with SMTP id smtpd.web10.13503.1698859067905031086
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Nov 2023 10:17:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zs2sFmaP;
 spf=pass (domain: siemens.com, ip: 40.107.8.51, mailfrom: sari.sercan@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+lHb4vS2NKH854xYGFJwEPyZ7VxuK12MC2xWAyNVpPBDLUSXjBpb6l1xUsuloNudWMrR79jF9oBlRuVogafOmgNN83n5OBWqB59x4Cac9o92pQGrzHhsP5oqcZU6nUfyULv7qS3qi7s2w3yh3dX5avxqZlwnlzi3jOMFQD78zS0zhfaRtlkB2M80K+z+9Jp8YMItIJHlShYEugxkM3EdO7r2/j7bH/RU5LDvmmjGCLxoPhVQR1vk7Lgb7v0LEJjuBVdWbqRR3XG40JOG2CLvIfucJQi1aLj86uaSfhiRZ/BHBzbNFXOJBejWbVBvrsWA9YndM9WhpreGDcVcFgKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWHCVMM0YUtG3OFilEQ/aMAt9gOeTFVMcJNQqi+G5iY=;
 b=GlJEjNlcoYDl7lh448LakQIMqA0VuxQd6KS6XAEI7odk1h8l259znSeKWYucd8g80F0MxWX8iEGH1ZgVLFKxMt2GdNSDMBQHte4RhTHfUsfcTnHyL6/DN67o417DuQRjtxboXzV/fB4zCDuob66wXtTnV7NJ8yf1v/Ig8AJ5KUKWRH5wpDuNFBaPswuaZIqkxPuvla8/r/Ilp5FAqsq29aGzK/PPNxqn3IDIc1ka8go3PwEo4J8EZaS9gfBR+xxmq8l01oXIXlOR61sDuNaqcSPwfyivrUO0X3b2k+GIaMRQaBTWC4CzXQxFGC0iCiuC8T3LuGG0boU+ILs6xH9skQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWHCVMM0YUtG3OFilEQ/aMAt9gOeTFVMcJNQqi+G5iY=;
 b=zs2sFmaPwURH7bUD98zhPIDM+vf1nmRAxZgGJEcbaQpTneJwGP1wcdgSlYlwU5LyhxKW1uzMi/fYfVgQeZXPemB38PDxtTbmfMVT0yd84VxFhW2MwcicvvHQR0mmeNq93V8Zd2IqWxGUHnfLKH63mEQdWC463nbpTwZunlZpv0YBtQhMsqtwcjhkOyOZp+9IX3SedI6skSVJQAuw4Ct0TTxwWhN2KM46YICnyXs6mvCGQMXsmr2F75q/7TlfJv9Te6y6xWuyDVP1Vy9huisXOt4cFr2L8UFd1QlY0yXWHn1B02vX5y80DLAfk+XKVpqvEU/7JmMkEhcrzibenZZb/Q==
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::17)
 by AS8PR10MB7232.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:618::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 17:17:42 +0000
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::634a:5ecc:7023:f9c8]) by DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::634a:5ecc:7023:f9c8%6]) with mapi id 15.20.6933.029; Wed, 1 Nov 2023
 17:17:41 +0000
From: "Sari, Sercan" <sari.sercan@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Sari, Sercan"
	<sari.sercan@siemens.com>
Subject: [isar-cip-core][PATCH] added pcr_bank for clevis
Thread-Topic: [isar-cip-core][PATCH] added pcr_bank for clevis
Thread-Index: AdoM5xnui5+ATTT0SDWBKqFXTIkKDg==
Date: Wed, 1 Nov 2023 17:17:41 +0000
Message-ID: 
 <DU0PR10MB6898A9738AF1110D653D5DE5F0A7A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=1e371b30-fe9f-4d03-826b-fdcc424e2a66;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-11-01T16:49:53Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6898:EE_|AS8PR10MB7232:EE_
x-ms-office365-filtering-correlation-id: b36281d9-721a-429c-9d51-08dbdafe7480
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 sTo1jN5vBoJq/ugJh6NxE2GZ0zzXc3GTBySo0euYMaVMG/EWc0QcUpUeY94fth2avwJO26Yn0cHKT8jlS8Zqe3vHom6NC4+Ii/YexfhmHIXlRodtlZSPZ6BbldUP7E1m7O8yjy64i3hzEvgiK6Xt3H+wYCo8oZBIH1fXUUo1Zvl0ZjwSgkjzZlu66YbI2dVKTPpaAFFEjlCVym8EvxbxBI64OxZJpU9zXnFl8v/v7qHkosxANIKfYEG7ehM1/jart53SYwv36dV8XDVbMu7a+Ye0kYEEoh1YE472WmXvMdljkaHSKsAaKCakIuMF08Ge8/1LjTf7bxz8qyPDeBTHcs7oGVkiglZDLaXfrqjKTWnT6ZQG9n4pDUdcV1f+u4Bg2j7YbykSj1++XsMWUJo2YS0C85eMicmi8AkVus3LGcfkTKXMWPd6IURfbaupmTz5Ra0wGzAQ22I//AkchTkje8pP3TIXSnCboeiYc1M09t9jDj4njI+996oS9EZjNvB01GlLRnEd9Xz3pSSLURftxJWo6VjJQ1qNdpkWl0jlAlUa3jmHzmaZGoVRGl7vVND4qqy8AgSufYU181HvWp6x3i7srtZKQZaFhYSy+jMaLoU98eFp3sA5u1CvJfV1HC4V
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(71200400001)(2906002)(55016003)(478600001)(107886003)(122000001)(38070700009)(38100700002)(82960400001)(83380400001)(86362001)(9686003)(55236004)(33656002)(26005)(7696005)(6506007)(8936002)(8676002)(4326008)(5660300002)(52536014)(41300700001)(6916009)(66946007)(64756008)(66476007)(54906003)(66446008)(76116006)(4744005)(66556008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?4BAORBdmeQe9dHJy0B+EDanolzZmClSPfrMNKcYm7+8CqywWb96Ve0e9UCwl?=
 =?us-ascii?Q?y8gDGNxRQdHc5j6hc0U10Zoc8v5pdrgQMILlKoQiUkQF47+CmMHDuZtqWjDY?=
 =?us-ascii?Q?QNYW+UJL13kuYYdKqpfyqVHEIWQ+2noP6C/nxz3iFBz3+aTRrkYmHbU3SM35?=
 =?us-ascii?Q?5v2hzHdEHaD76cFD+us3SejCS+Yv6EnoZH5Zm05hXLpjGW+CoGBI684J6hpw?=
 =?us-ascii?Q?x+4h60MZkamYGt1cSFIjJJ7wXTUQk9ub1BUcR6lmM5Se2Bobk/5/1qy9vdoF?=
 =?us-ascii?Q?SUHg4O1qkV4teZ4lqL/fpLhYA1zO3iQoIXYyvW0/BvIh4pImCawlDdvrQMVB?=
 =?us-ascii?Q?cZRPW91XtNrBfY9X2OCSpzycCSIKOQCTAmQSaSuGI3lPHIEWv0wRObDqZIH/?=
 =?us-ascii?Q?aFKq/hkzh3yT3p+gsRdIZEnXSIDjdIK7bw63xmD4Y7BYwJ9ekfXtTWcu19vi?=
 =?us-ascii?Q?NeZJXH4gG12NyXLrDbenN9hebmAE0ssHF6mNNDYEYMfBjVT+rZG7VI+Uehhg?=
 =?us-ascii?Q?kvYbl9c23LOWQmiqDAay48rsbWgF9t2x0I59CNt8oTOOBAd0VozEygphdkOp?=
 =?us-ascii?Q?RGNlHSEBLjGPUUXwhDkZ0NVD9EuviMFqno2BD60tKhWnnAEvjV/zkq2PDJVs?=
 =?us-ascii?Q?1uxzrvNeqIKUICQIAWsiHDKlhryT0oy+ce3GXoLLfvv6JieKfJIeyfI5xVAe?=
 =?us-ascii?Q?Tw0dXZXyDibghlBz/ImCQGnckJ3Oydgi0xMIIMGRFC4TGlxrBSwqNzNChoGm?=
 =?us-ascii?Q?un1dl4BOOEWUtmibTK2VPWH/i/DrvlqFth9aqZ4VQJBAKnIRlXnB8/8gaZ+C?=
 =?us-ascii?Q?IxyjECIepkpq3cZLg9PgzHfb3lwtlyICmWT6jpoVmP0Hpid3Yd7wu4/yi9CM?=
 =?us-ascii?Q?yjnN+aB+kbY7wCeFSHO+RffDBId11GVTD9+VHzyqyxO53Wnou6+O+aQ7kBDF?=
 =?us-ascii?Q?OJx/96kHwMbt8ypcSUiBI/HXOt3hc+P+IBPBFFisYo7LM0vsB6K/hLmZ5ptV?=
 =?us-ascii?Q?kh10rWILVYkht9pRsRWeqb1I+BkAm5oWu80NX2xhytSkJu0JlUBd9lMVww2O?=
 =?us-ascii?Q?PEu+DbgYPXjLyk+vOGgsFlYhJGkubzA+wGfqN9RjYcpfQT/07A+GGMqwDrze?=
 =?us-ascii?Q?kt8fZCIyKQ0eQfua0QmLzqaAWLSLcc51WEyQDCCopibHTYC+XleoNvtupVnd?=
 =?us-ascii?Q?3pgRGvb2GPY9BJhv9ZDY3DlXMdUxqHxebKR3pBppzEZAl8N8GTfHxdc2yE19?=
 =?us-ascii?Q?r2i16RzO54ozkIV7B1MHLpmK3dvX7/aSfbcEgdYoqJnyKX1pjJrnAHoBdPzF?=
 =?us-ascii?Q?+D1JgqmyYBOEHNKlOvBYxIpcfAv4XglHWu+a/LbIa53AF5rEUy644EKqUwDC?=
 =?us-ascii?Q?JHdMFZxnF9KZyDAkukxphRM9iT/F0PGxVbnmei0VVCgbt8nlZii/xrg/4viU?=
 =?us-ascii?Q?fEuwwblZwr3BxhnC1zjLZKcvgyxJxE4RzlajKgyaULpcWbUPPix2n02GIVr3?=
 =?us-ascii?Q?S40jqDZ6Ca/bZEdjOa6T2FF/LxbuT/cKx81ixZXlfJDGOB9V0yGyjwr7V4G5?=
 =?us-ascii?Q?pgw06k9+ty9Nrtk5mlBoFdv7B8peXv0GH3nnLaIW?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b36281d9-721a-429c-9d51-08dbdafe7480
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 17:17:41.3651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j9bCqzRBqDHL8rZQmsL+SyXWxI6K1YMbf7lNlTysg8JjzHrEKauod1lflRJ16q1PU8pZS+vPjvkex+MAaeldVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7232
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Nov 2023 17:23:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13507


clevis will fail to encrypt data when the TPM has multiple banks, such as S=
HA1 and SHA256, adding the pcr_bank information resolves this issue.

Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.clevis.script  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_parti=
tion.clevis.script
index 899f20e..957a3fd 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
@@ -61,7 +61,7 @@ open_tpm2_partition() {
=20
 enroll_tpm2_token() {
 	if [ -x /usr/bin/clevis ]; then
-		 clevis luks bind -d "$1" tpm2 '{"pcr_ids":"7"}' < "$2"
+		clevis luks bind -d "$1" tpm2 '{"pcr_bank":"sha256", "pcr_ids":"7"}' < "=
$2"
 	else
 		panic "clevis not available cannot enroll tpm2 key!"
 	fi
--=20
2.25.1

