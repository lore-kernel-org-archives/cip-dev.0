Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B7DC369C2
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 08:51:34 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.30])
 by mx.groups.io with SMTP id smtpd.web11.35424.1745311892820827187
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 01:51:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fMPXYC5E;
 spf=pass (domain: siemens.com, ip: 52.101.70.30, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdfzMBBiK6CU0AstXU9L4T0kf7rd2uIjhAlltf00cEmDffyfA0cbhG1MUuevydv/exkZsyYLAvxTYncZ5wVOanJqnmMldj+jEqDo+NASYJNvtPxVhktIqxPhbdrBqfAlNHbBTVmVCOa/CpDkjvQtVLzxdDVnFSJxjGPnKbtlFMf9d6HmWmrJrr6IvDVEdvq4hBIYeCHpW0DX7UIFk6KAxPJ2vUfcvwAdZbcvFQcSUVMrap+rIzoGDgx0siLwbX0+KeO9gP/gaa1VGAvlUSM6fsXlrvLMZ13YmWe2zYOg65QgDQZ57DErY45G3v2/ZmwQWWFDqjbnegSeX4fEyq8Hrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MHLoeY28XYzktYSpgfk3wHjCuiLeQoGUnJTHHKAIRI=;
 b=OvDOq03AfZ+MTOso/uMTQDDp3caMEtR8ZOD6sb5CbZLryBl0TudQx8AD5ezCOyT155xLSHKKW+5+GnWRYoixiijXBrzij5JLr+HUmTNhjyi0iUWiI4+pTdWbS6lYNSpIrI+p+3yLVqEOho4ceRR7+Dlb02oKeweQKwtIMH0yXLOY5H93fGfncB3umAOLbeguZR/j4UeVRWzbb+yysyNc2KTxLIib61z5mfKmk4f0HbB4p4oDPzhFE0VkxokWoQwnhurYfP6e+ZLdl2YcX5vVacGOW5PnsszGJrpTUNShs2aNtyXehkF/kUMCiJ3NM1G5Y+3iIs9D4KeCD7/pzztwyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MHLoeY28XYzktYSpgfk3wHjCuiLeQoGUnJTHHKAIRI=;
 b=fMPXYC5EytuBV4ZCJgrRYw+Zq86v5M2TmlKy87e/TIwHeqXcdntCrhdtgyq1rnUjp6nIxe7RCseA2V7NaPKylnq7CA63LBeokSAgqYsPjD10HIK0CAPGsHunx+bhN6uQG/n5hoTszcj93ijiFoo5T2zjauOxl0BYag+MZFuH+jMDuvknlbxalVVaYJ0I/X8OrzDOg6BpwHTP9uXrPo8yK6Ms/Xt3FxMzsd2lCiLaYOIsR9wvk5j0XFdxhTJQUhq/iRyZqHDoLoxoRX+BhKhLc8tCZZ1emZIiiRBMDjq2RcxF5tAUQSGcVRxjLXIofI4XNxPwLq4bcIXKlu6dTfTumg==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by DU0PR10MB6440.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:407::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 08:51:28 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 08:51:28 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>,
	"MOESSBAUER, Felix" <felix.moessbauer@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: [isar-cip-core][RFC] Handling UIDs/GIDs on Updates
Thread-Topic: [isar-cip-core][RFC] Handling UIDs/GIDs on Updates
Thread-Index: AduzY7uY91hdKRz1RMaaDZRK7D7V7w==
Date: Tue, 22 Apr 2025 08:51:28 +0000
Message-ID: 
 <AM7PR10MB3320024DB860319B2C1E8D9786BB2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=66a2283d-565f-40c4-9a5b-44555d45fe69;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-04-22T08:24:04Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|DU0PR10MB6440:EE_
x-ms-office365-filtering-correlation-id: 47b8ed43-b8d6-4232-718c-08dd817adedd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?fY+5Rsw8NZpzFAPKa3NmR/keN+e6y+rl6xb8W/5h8bHDN6jxqiF0D70YzlUb?=
 =?us-ascii?Q?mXFz2NeSGAzPCzB4DX2yi181OMFYaJYn6fCa7p7JWHCein0QgRBK7xuyZJfo?=
 =?us-ascii?Q?ZASU+DcyxMEu8ChC0bS+ZkD/b4/JPPpkg0kgi4tPZDwPFtiifCWvAU4jk8e4?=
 =?us-ascii?Q?bVTy1aV6qy+AlHygrcreaChKxE+b8o6ZEigdmkJxfyHV4zXwJOPzEi2WaXYw?=
 =?us-ascii?Q?VIyKb2HWt1sHJ6nqo2RBUpXbSFHcT2HQByiprM3rnS4scNt54B8EP1C96lZm?=
 =?us-ascii?Q?COGYB9XpZi/kQeg+r4zX8Fhc0JdkMIODBn+ckPIUDdgAM268x30JvY5kn1ai?=
 =?us-ascii?Q?0bmCxVlDD4IntTZt2i2ac2e1Cv9Np17Jqr2KzPGLV39yN1UAk2cgOzOPDO8T?=
 =?us-ascii?Q?+R4RzKq4k8D+s13C0D59QtfcfuHgZzgBPs4m/s4watHnShMz0aUiz3kUJAcM?=
 =?us-ascii?Q?4bBf2Rsq39ALPXvEAaWStS2KUXumw24/6LQgi0mVbbHEroGfOMTSHJxqmhgi?=
 =?us-ascii?Q?x4ZtFcGLQUQwVSuTk74qA4iYkon9b8A3T6NCHdXYzoHqmc9lV5tHeDTgKgNg?=
 =?us-ascii?Q?T6He6SLrkoPCJ3M30NBfkQPyOsgvfEdMxiDGvWKK9Nqes+lkA5EKFocY6aeX?=
 =?us-ascii?Q?EuOSdoDxwvfl60AxF4QZP3D34emAk0RI6pWAlFVj0izQSsP9WCt4zbgyxBIP?=
 =?us-ascii?Q?JNMlojZZDSL9usVClLJNoObtFCYT1BeW3WkhrqRn1JccFlH+y1SKQHHNjBT6?=
 =?us-ascii?Q?rqJardjJm/RyxPrV09h3mOR4DhUPk33rhyWOIIKbysH+9+HwFccfGZ10zcdk?=
 =?us-ascii?Q?VgHmBEIAgnIAo735vdX53gV5PdqTVsdV6ZBIj5RVdVeM7VDYZzTWzhoPWR7k?=
 =?us-ascii?Q?NpGrxmJVC0X0Ta5s+fLYAu2q2AjtGNYnsGDUc2iz/YPzGXa/sSX4O0nT6tbQ?=
 =?us-ascii?Q?/QAypdKW+lNL7vylcESH5woDHvJN60/3rIYvWuDowcZ2N99K7F+0FoVVF1I8?=
 =?us-ascii?Q?ShoRr1nQiYwSusNyQ4RxwLmnw6TJz9rIoxtoeyI7gIPGTHu2SpU2Lpvglae3?=
 =?us-ascii?Q?cLbP+Jal4ROnVjBLYl3I/PSUczU496spZLvTUIkYfq+rBmJFiDJAnhzYXY+0?=
 =?us-ascii?Q?4REstwMQwuGuiToWUuYaLaKMG0VGrtmldUTr0J0XU71DUnWBsykGx4aFSJ2F?=
 =?us-ascii?Q?btgtoz7m1sKjpiTq6MyxhVn3ETPzsd6e5JAR8LB0JIR2+OzAVWNDg71xXndc?=
 =?us-ascii?Q?b2qGZ5A2cmelGY5+22QoFuP33aahUmlPRzKC4Ee3t+zFdDRt2VJ6Kw6H7pBL?=
 =?us-ascii?Q?n876s7ZvXhWVu/LfWnq38uR/UVZMAscmkFYeUuldT54P1GCvvkKhL6+5Jxa7?=
 =?us-ascii?Q?noRYQ8SBiuzcO1156GUDBBiuP8wuVZGVJPjXPs9oCqvmRQfOYjjXIx/84oz2?=
 =?us-ascii?Q?quzXVg1UKFJ4Ra0R29bY+lK3wjD9WbVBsKfEoMvtfv64aV/xRa7+C3zzkoHa?=
 =?us-ascii?Q?8yvJvzo/ROD3OdQ=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?I/6VXzNuOEFJybBGVCHCBKBOKl1AxMNNMTniwaH/9enoOzTmSI/oM56FoaED?=
 =?us-ascii?Q?yNu/TLV22IZ5ll9bKSSYrnZ/lBdULnKNIDJhCbqWgHRoW6ZN1aVOVvDTudJx?=
 =?us-ascii?Q?VKtKPi2/q1jvUFTUDF5u9hLLQf7VWlm0yZ+avs9rb9rdGBeq8iLPxm+ekz3g?=
 =?us-ascii?Q?e538f3XHgfoTTEpga8w14e+8ei3ZV1EYmPSYJ8elKiO2kkQgkFVw0ZJ0vJux?=
 =?us-ascii?Q?xNvaOnn0eN6cdAvbR8PZzfASehOMmaogyCCcc+wyrQI9BLqX0xhLcotMKIYr?=
 =?us-ascii?Q?M+ARVE0yE0VMGOm+ldoq9TbCBdSAOGBfiKsctBOH9GLPo55NJM5qkp403ZXd?=
 =?us-ascii?Q?InvAHd4KQZp6N3wo1G0Y5eO8/La6wHg8JKsiDXcp4wLjoIZu74z/cL2nuMyD?=
 =?us-ascii?Q?VXkFtRjpMjJSBbBFRfkrHfqIkoQznwLWtUoriBOz6zCNTNGVoi2G3gMugubL?=
 =?us-ascii?Q?HJZsXcBDCJA9njGAkRprBD6uqxMRskPK/WaqC+NXBwwNSbbKhJEpOhx5rzRT?=
 =?us-ascii?Q?b03zBVCYjKTJnfkSh6ib2rnJsmpml5c+COqLW2sBEFtklHRIJ6NX+Ls9XEiu?=
 =?us-ascii?Q?2KetWdBCcS+NRjcuTeVbGexIcmuqVOWMbXIOi/SQ71F60mI91JGZJ/kJtrNf?=
 =?us-ascii?Q?V8wTfRx/X5De+6CetAu+IJ4hxQKWexCCeXTBzY6dks0R5G3sTbEfT9KfBkOf?=
 =?us-ascii?Q?PnHXLmarfj+kSi1lm90rysCx4rJaL7/lKX0yDWwjaueO5L4eK983Sl6E6r45?=
 =?us-ascii?Q?O1eQDHAEWQdJVmacU0SIxqfwu64HTvypZz2n7nMN1fDSxvE3XrzmaEKsuriR?=
 =?us-ascii?Q?7LiRxsbflmt44EWJQM/T8TMWaQHtf88CQh1A868ipMeea4gHKfCMuVAzJjkx?=
 =?us-ascii?Q?rwh1TvRj8/wKyMGIbrrPhBXMG66yu5XK8dtKJfpUudDErEFGuXVRqt8m66bp?=
 =?us-ascii?Q?YlkJgVETIprTMGV6sdVto8x07P5UvYDI7iTkvNF0eZ7qPsC1xW079S8yE6zD?=
 =?us-ascii?Q?NxKhjVE4TlHCHT2f8zax1w1z7Hr+8QcXtW/4bWxNPhfu8bprnGHVL/KS0Ejf?=
 =?us-ascii?Q?dOlIPaWX0qoGdiL6h7/js5QBiiELSVQ3C1NrZwjR+HIDqpJe8uEbfL8zFNAa?=
 =?us-ascii?Q?wAIe4swKVBPVPUw0Ql2H2geRX5bbXTPG6FePaKNr03KBBJ5vrbXlcpGOEOeu?=
 =?us-ascii?Q?pAubwn6i5ddYMBHfxvKhnrrOUmb7rA6RRqWVmpMEuhnfIWh5GTpRHEHY8Njf?=
 =?us-ascii?Q?zcFXjDAHXc4tVbLOPY6FU5k3HCSomoIA4cCcYekfq/3Aq9EFWYg8D9BsPKnU?=
 =?us-ascii?Q?Oq9SU3zFnqPVXXSEr2Xmuydham0DDGxl0jOveWO+NXltrH78d+V7bH54Yoqe?=
 =?us-ascii?Q?zyxS+V4xp3E+ryNUI02JTQ82IDMorFAmPEQ1iIzWHYEncDqBzSeIU/mLKwdR?=
 =?us-ascii?Q?T1r7ckN/7sK0kuA22gVo9O857tM60fjRGBSzoEobJOIrwEKex0m/TLOtZGrN?=
 =?us-ascii?Q?rr7wBp1obuxs5AHacF3W7RISltN6uNxAkV3M3X6jmkAA69jfYx9vjOyYgEHA?=
 =?us-ascii?Q?hYMEWa2xHSYhd1ZbWmt9kd5bo/b0tTEq8etxGukffQWWj2SuufqaJRLyGKPl?=
 =?us-ascii?Q?nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b8ed43-b8d6-4232-718c-08dd817adedd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 08:51:28.0906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QlG8QP0UZxZTt7req9pNQ2ulFv2s4fpQLxIadRbanv/uSzPCIoZbfRD6WCump50pJc+3eWYXOz0M2VP+MoNBiwSh/DyEvAvE2rlliEU9PSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6440
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 08:51:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18542

Hi cip-dev community,

Following RFC is not specific to isar-cip-core, but to the upgrade method w=
e are using. So, maybe some of you are facing similar issues...

The default update strategy updates the immutable partitions in an A/B sche=
me. Typically, the persistent data is kept as is (at least in the majority =
of use cases).
Some exceptions exist where minor changes (of small parts of /var) are supp=
orted by packages linking data from /var to the immutable partitions using =
tempfile.d aso.

That leads to the following problem:

Once we added users to the image with data on the persistent partition /var=
 the UIDs/GIDs must remain consistent forever.
In case package order changes, or new user accounts get created in between,=
 this could potentially results in a shift of those ids.
Since we only upgrade the immutable parts of the system data on /var remain=
s with privileges for owners and groups as they were before the update.
Thus, resulting in a privilege mixup on /var after upgrades.

To (partially) fix that problem multiple options exist:

1. Define fixed UID/GID sets for our users.
While this helps with our own packages, it keeps the problem when using unm=
odified upstream packages not using static ids for uid and gid (e.g. wfx)

2. Use tmpfile.d to modify ownerships on /var accordingly.
While this also fixes issues with upstream packages, it requires additional=
 tooling / automation to keep it consistent with the ongoing image developm=
ent.=20
e.g. ROOTFS_POSTPROCESS_COMMAND or similar.

3. Use a static predefined /etc/passwd file like in base-passwd.
Unfortunately, this does not scale very well, so we need to know all possib=
le user accounts in advance.
And further, we have to ensure, that we never change UIDs GIDs (unintention=
ally) in that file as well.

Any recommendations how to mitigate that issue?

BR Alexander

