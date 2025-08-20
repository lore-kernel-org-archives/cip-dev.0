Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A89CCA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 05:58:08 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.16])
 by mx.groups.io with SMTP id smtpd.web11.13076.1755666741717172347
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Aug 2025 22:12:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LyLTKXM/;
 spf=pass (domain: siemens.com, ip: 40.107.159.16, mailfrom: sari.sercan@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9Xy6knuYI8TjjMS15dnH7TPlupElFI5P5ciGJg5fYec52CbxCf75xKVuxhDuan4z8LeEkmAiwtyzhj8BUTr0AWDL5o+xXfEeT0rpwcNNVpIhhLMeUODgukcAOLHV9ICsiE/JofCdSOk+Tg0h/kI/X+hZffM3b8590HBHNW4F6uC+H3nL9sMi1xsu264y09EZ2Aw7WWDHXKoUxUWynfQz6Xp03IJm7DrqWIKWwj3y2PIGIZVQo94nezhye/cSZaoyb4Wdqj5TMwNWdJVT5hSsbXDCR9JrGIu/1nRVj0s5lp+8T6XRbaLzzQJE5fCKx9NOX8N6Y9ynj+WglAs7ikkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFK2uXIODbL6xwPzRUz3wah/VfWHt9FnMhlQfSJtUe0=;
 b=A7CyxfCE7XOHXGW8MkERXSKhOVA0zpMneFFOotyTgEnv0FSFNmD2C+tbyqGO7nYJnTRbfh62zkYHI0KXc4TiyPEZur/k8AoSeudfKLBTc/oK/LJYIvpxUNkp7JzsjDFjlS5gpT3KB+v9zkCkbymoHzHOkUWKMdKcYFpHSU42pRY/uAgva7EsvEwjxvg283y1e18UM9fc95UdDdNl9ekc2AsVokgB7ENHOx+1Wb6zvwjtJlW1AmT3w7k7v76icIBEQttaHetMeB8T/Gtk0K+1drHUYapk4BQoiyOeypbXGCgdDAbWZkVsaG7k2TOaO3BVSWLN1tdwzIdTsQ+2hxqgPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFK2uXIODbL6xwPzRUz3wah/VfWHt9FnMhlQfSJtUe0=;
 b=LyLTKXM/fpg9BRQrSdHLEGQxzrnPxWyJKGJ6keeAFV55MOz+JAU/RxjBaZP93jXHASh1dxgDv41KJDxN4YIwR79qf0XQ51CwYl3fuGbpG1EWyQMPaV2DGGusluhlP+dkWasu9OcAxIpWcnSmJz/THicrSBUR8gXHkP607SF6iyvjOo5JEI5nEmkGHrxUD1u/DzAlz9EqzHiY9TykvHIOi8178lc9A9LoSXG10vWvW2z7q6nnp4bbLfgtmAixq/BiU4wDqAVq5mXFM0aQbgeb8epL4Mk9ZypanLFhv/U0c+zCK/ldOMhbKu6QNweINPqREAmMo3bEnGTSIGXXJ46kvg==
Received: from DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d1::13)
 by AS4PR10MB5944.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 04:58:04 +0000
Received: from DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::515b:f0dd:e17e:3e91]) by DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::515b:f0dd:e17e:3e91%3]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 04:58:04 +0000
From: "Sari, Sercan" <sari.sercan@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH] initramfs-crypt-hook: remove redundant logs from console
Thread-Topic: [isar-cip-core][PATCH] initramfs-crypt-hook: remove redundant
 logs from console
Thread-Index: AdwN5pFHvuL35QuyQRG71Y89pucLmw==
Date: Wed, 20 Aug 2025 04:58:04 +0000
Message-ID: 
 <DB9PR10MB66433A47DB000397BB6EA9BDF033A@DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: tr-TR, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=0a0d524d-9d79-45ce-9133-f926e04301c2;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-08-15T13:12:57Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB6643:EE_|AS4PR10MB5944:EE_
x-ms-office365-filtering-correlation-id: d314d541-6d6b-49b5-0812-08dddfa62596
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-9?Q?yWpa5AYIn9xLRfT/lRG5FbzH/wLFAExSzZVN6uX07ykqxL/gA2O0ANhXex?=
 =?iso-8859-9?Q?f+6W6B8wPgq5zJuxM7Qp3z/5KjAvBCPGluOBEr09kNFi+HvGmyGXk5WYga?=
 =?iso-8859-9?Q?dzL6SOV+hAyhC2aK4aqDdni7dl98U6RB1POMHh5yhLhjym3xAJaiF4uz5G?=
 =?iso-8859-9?Q?GLsjXPiaD9SRzb/CUxXlfLQrD3p29nmtaxXw23xl8fcSsgP8lSM3MS4A3p?=
 =?iso-8859-9?Q?NYAp84l5rD9Df7vfAetaEd1AHUEgGZ2fPySUyLdO2qDkDRXqmSIW70TFVc?=
 =?iso-8859-9?Q?HgnNKAZ8hXy95wirf74GRHPr0kujw+J6kjAK0Y6kiEh5wfhKGPv6eIVrb2?=
 =?iso-8859-9?Q?HvcWkgwYmlJXNJOda2qxc2JqGI4O0UR6QV69k+wWjoo0bmPbOrTyAZ5hiS?=
 =?iso-8859-9?Q?z2g49vDArhSD7vlmlj4yu+WyvoTJ9K2TWOxIV4ZSHIUQGkaGt8pLSpvZv/?=
 =?iso-8859-9?Q?Jwwvxsl4ITKXTL3BhM4Xpl+vQJw2IyWBukq+eGUXW9wfLGNuPGoi6CBHpW?=
 =?iso-8859-9?Q?pUtzsmmdAjrRBrxrP8Niaf7VlAF3dNZXdPkFkKry94JQfp6QzltSM3EdY6?=
 =?iso-8859-9?Q?ZzOFm6pFD4fIpuBhSoL0H8j9kl12KBD5rPCmFlM86MHInXn8woM0IMQGql?=
 =?iso-8859-9?Q?a3/afRw8uF/N0CZLIFI1YtUcb+AWUQzXfpBhemceujbCfd5YygzjLb98W+?=
 =?iso-8859-9?Q?q+KaSh4UqQM4CNQavYvi8ygxYxndmIPx9Bsc97z674EyI5iOE411DShNL7?=
 =?iso-8859-9?Q?hfpMUHUTx45rN6J8q/n+xO9+yB8LX/MuL3I3Ixgpv8bhQWKVfyuJ8LrUqy?=
 =?iso-8859-9?Q?7oh4xQmD2VTEcsK42c7Gj/tRmqQUGfm24P0xiEk3fnpQib/n+w9j1s1e+a?=
 =?iso-8859-9?Q?ezjF8jh7XwgaWj/foDE1sFstvOyTkj8AoTJyUyEFstcMRemvAdEs1yqo/G?=
 =?iso-8859-9?Q?V3IFBnjb5br2rxv31AKZxndzQnfdGH+hAB0ZacZ+MqX2L/6n4wfJ3loORS?=
 =?iso-8859-9?Q?C/c2bU8lxzRDo8DCwjJpGVcvjiykUpDZJRhH+b41iRCE0zwUKJHAo7edLy?=
 =?iso-8859-9?Q?3B9H0dLKMxF6Wyt0aKh2sFGSAxStEsESQs2xIJzpj549sOX3pIzdp6oCZX?=
 =?iso-8859-9?Q?bLGSI0NvbgTCg7YaqzbXERxrSO1bxacFTsqJfUq3RI9ueOES0tSlWEwNO4?=
 =?iso-8859-9?Q?6cXBLr2TZz727l44g23V8f3HlafVds+wvld8HSSr1PdP6Z/uOqiCmudSJ4?=
 =?iso-8859-9?Q?SZup5yiD/1p9ve9VYwRrpslSVdX8OC6IFAf1dn/lE43kZU0XB3EUihUQ8L?=
 =?iso-8859-9?Q?jFA6w95X5gvlmYTGKFVHgbC8iW2GvLzfYohgUgcBFWoH0v6ncj/B78u9EZ?=
 =?iso-8859-9?Q?PNzqRvuhpMn61zdWVySnw3QqIRyRiaUHH2dLntiazNY9oaOKKocoESUcRJ?=
 =?iso-8859-9?Q?AldGEwzs1nLccnZzFVpT/wHI6HaO19P1tdvnHWRLbATEXrzkbF/fHwOpHV?=
 =?iso-8859-9?Q?bdJidPOG0StxcIB+8b9sLB0JJzXcHfhpluVxER8uQ0Nhn/8zRwIiytqit5?=
 =?iso-8859-9?Q?k72b3v8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-9?Q?UHbPH2iySzkguw+FhPHsoMx1odcSuGqdwxbwMO+moIpm4X7TDZMTnyHM4A?=
 =?iso-8859-9?Q?CL/YsAPmE0qKjPusLuKpRuOUC2m375MjpYJy2n4bR9t+AMDAVXQIaSros/?=
 =?iso-8859-9?Q?XiGSnhu0xG+yOjSlwQwudfWMFawyJaS2RO6dG2jjpIi22Q5tNe46hH/zEi?=
 =?iso-8859-9?Q?W6WF7lCw/P9ckX7V8qRe3jsrCl+iEiUV0c2RThVNXgPxl0Rk6CqF4q6kGi?=
 =?iso-8859-9?Q?6OOfJAO4f8FWHYVPvt+CW4HvJEEHkczAjEnIJgSzy1xgHjXpXWh9ZpOX6R?=
 =?iso-8859-9?Q?UYIKzV1amuXK5NT9vPUHSKZeg6D/0YfliFWCFLNtjS0IhPkqJP7ZYZCCuz?=
 =?iso-8859-9?Q?UNtVFsBcqLj6X0C0joENI8rfHSDZGqPhS+pKlWXDAo8KS3NHzl3sg7kQkw?=
 =?iso-8859-9?Q?FjVAvevOo60+9ieRgA1Yob57I2hVRLy00D4GkoWuc8geiXs1KB8XShLe7W?=
 =?iso-8859-9?Q?ZstORnb6RJlvVtDQb/R3yG6V5ZlDnJTKOw04GAHuxHj0CvILvHpCBXCqtw?=
 =?iso-8859-9?Q?p/41mr8bDnYGKkAXUwxttdsTMGLqqAunvpBtayYs2IhL8f5J2vlas+Hg4g?=
 =?iso-8859-9?Q?7UEw+yBBfBBXp8JkwfmLWyeHEBAyG6BHhwK4hbYU0lO71npLByaDUGJlIf?=
 =?iso-8859-9?Q?5XhVL6Zz0B/llc7YGF50l6qOB8VdjYSqOGgk662wwa00+SXVp+VB+WmVof?=
 =?iso-8859-9?Q?PmfGkjcvsij7fgAlg8Q6SVdxi7LNm2hk/e7UykynParNEaMHs8S4rXl6VL?=
 =?iso-8859-9?Q?r0UpKtFVbMV4Umfs9GUO4CzsMIZ6XjYfEJhwkEnGe8sdqNPNyHK3/rabdU?=
 =?iso-8859-9?Q?WOOQpBDOR/zsTJ1qtUe13tAic3HNQ2wXbuSOSDzSB8l5i4cGz2SYc8cWoC?=
 =?iso-8859-9?Q?2KCIHDTibcjZ9ob0A1ogMV4VIOVFpYxlP6vEK/tUs6d8VkQEnrb2HGTGvi?=
 =?iso-8859-9?Q?zjYjyGVv2glf11TeXf2RMBwRjG2OvHCjyYUACmNzIeT0TnozFYR1OFG76p?=
 =?iso-8859-9?Q?54Suu4YFAh6j6UolnBrrUN6LAYPvx2Jn0uKuvw+3QLCafXKqf9hJRMVxWK?=
 =?iso-8859-9?Q?cxzCVVQRNCHbWdVLxTbL7iH0WZ9GUKaa5fxyi7NN0PFO1DS0V4CYMMdBhc?=
 =?iso-8859-9?Q?XdTDh3Z/sU73N8vtLdkJ55nJyI3b7cNt4OxwkSlTXgDeYDFj8YAXiBLQe7?=
 =?iso-8859-9?Q?4g/qiOwkeXDei1N0zx9/X+n6o9gD3x7XcHLNjDlms9n7VqUdR2ozrOZB90?=
 =?iso-8859-9?Q?EAw82ktzs0EeW6zQfOYFzZq78CEnmlTiW0YT1dLxYg6QnSdD2+Jb8aHGIf?=
 =?iso-8859-9?Q?d24BtJmJKjb8Cpra8dwa/WExR9MMn0udfmBTh1nh6EulQSW+7p7zanOc4M?=
 =?iso-8859-9?Q?IE9E/R5WSAn9Bnegv3R2Qu56NwXlu3AheGHmCJm7qN/bN1Edf3Dh14fjOd?=
 =?iso-8859-9?Q?B3Eej3Pf99Ns0i/VJQYcRrnmV7GzBDAwUSTgkohYfG+2DDp0xp64ES/UjX?=
 =?iso-8859-9?Q?T3+LnmwgSlszBqUVi3IOcrpld0a6AD7NHv3o3EZEqsK1Om+Fv4KzpT8F4k?=
 =?iso-8859-9?Q?Pvggh+Vj5A/r0D8pKjVxR+esXeZLqDQ8x1bIXzNmzXX5XJ+0+So/6M0gXT?=
 =?iso-8859-9?Q?GdY6glH6HUZHnfupH4vpMFhRUJvJ+uaHEA?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d314d541-6d6b-49b5-0812-08dddfa62596
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 04:58:04.4537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AI+nhyjGrZzazET0ZnimJra5w1xWBDDtlZgSWQgOaSwA7h2mH7djo9BfLf4i2BlMEySTUVB7l8T4zCA1D20uCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5944
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 05:58:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19767

it is already provided via warning message in case of optional encryption o=
r
panic message when it is not optional, no need to create confusion to users=
.
quite won't help when used alone.

Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
---
 recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions b/=
recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
index 01a4003..54d43f3 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
+++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
@@ -11,8 +11,8 @@
 # SPDX-License-Identifier: MIT
=20
 tpm2_check_device() {
-	tpm2_pcrread -T device:"$1" "$pcr_bank_hash_type":7 --quiet &&
-		tpm2_testparms -T device:"$1" "$tpm_key_algorithm" --quiet
+	tpm2_pcrread -T device:"$1" "$pcr_bank_hash_type":7 --quiet 2>/dev/null &=
&
+		tpm2_testparms -T device:"$1" "$tpm_key_algorithm" --quiet 2>/dev/null
 }
=20
 TPM2_HANDLE=3D"0x81080001"
--=20
2.25.1

