Return-Path: <ludwig.nussel@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2811BC0218B
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 07:17:59 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.24])
 by mx.groups.io with SMTP id smtpd.web11.6201.1737616670520227433
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 23:17:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=0DeCDgyj;
 spf=pass (domain: siemens.com, ip: 40.107.159.24, mailfrom: ludwig.nussel@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLrdo3Z7coSKJKQ6TEP8Ec3wZn0WoI1OT1d62+B7gy3sdK1UKKMvkQZef6IsTV36PAm1Q3KYdJvInuGQSnHcgcn+nTxEkrlwsuIzloOIW80cQnTEF+M5SkFd4dtf2lvLIWp636Jm6OO7+Odv7dsuJ5++keGYdvAyATHu0RMwMexuKoT1c4YCKBypdNJUYR44gFkLg6mftLFzwPlmyZFFjNmhrfGiyrv+ed6BzLsygUe8ur2p7/9WiBQYc20mF+pKhO2LjWxm77aCvqqVufpKo5dYDwflpYVVIZEZtFuXKokMKzX5kFMjTnuyvu0g6mg+wG+vRI7+CU16uwXRrTQuRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=na6DvRF7yLhOuhjOtWgF1e17aHs45/jTNpy5Y8goklU=;
 b=Q3FWzAMCLz1o3OUXuPjWEdq+vnevJKZQBw68owMpImDQCf3rcTUNweoXWEHkXa4ufhOLIWGzchxX5UfxqrbEFSYEUl6wWUJ9xRRllaSxmYaIPPfQdCK7i+yZ2mmCGUJnIHyx+Fce20O6zxePqp548ZWjyfOQxWjMJoXseYDwDC/+xlrMJ/MqEDvd/8lmTPME66TGCFMN70+BsM+kqiTHhCOLz8Sq6BB0FDLMFme5kkY/QMfmY/2pK1HRYofwgDrvDTYRHMgwhjh37GDJu3q/f/DeS1+Qx1iBdPzXmXvLB2Aygm3hBYnAqMlf8LxbSnQ3fW8xslS+/UrSmNQgGZ10KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=na6DvRF7yLhOuhjOtWgF1e17aHs45/jTNpy5Y8goklU=;
 b=0DeCDgyjFxh+vPJ2YqrfkypWOIqU8UnQ0d20XQfuhImw8YLd6RoAWUlFYL9cJpE4Gt8xgHXTaqPEcHDA0ws/amRpwxbxskFvdvIXlKvflfKIEaQ3+wjZVYERBHOitRYRiPIUXea24pKuG65WEgu55UI3mmVIBIVj+J2F2jjnHzLm4cvGsseG9ZfStRVAoBjLWs8Zi6vPReJ+5LWu8UZ3LLx1sio0iyyeiG4WICFgNYWQQV0CPKI1DBC89C1eOR1bPizoBgcBhIGjWNKeRtiVNFRZcx5kMWD0vuOg5/moZRWpgtGE/gCic/FRW1B/+ofFJKD/edVbYlmGmDKL4J6WdA==
Received: from PAWPR10MB7126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e5::12)
 by PA4PR10MB7962.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:270::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 07:17:47 +0000
Received: from PAWPR10MB7126.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9c89:16bf:ce23:7acb]) by PAWPR10MB7126.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9c89:16bf:ce23:7acb%3]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 07:17:47 +0000
From: "Nussel, Ludwig" <ludwig.nussel@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] u-boot-common.inc: fix FILESPATH
Thread-Topic: [isar-cip-core][PATCH] u-boot-common.inc: fix FILESPATH
Thread-Index: AQHbbWbnrI3q3eD4EEO4RcXqXLy8Ng==
Date: Thu, 23 Jan 2025 07:17:47 +0000
Message-ID: <b6e7799b1329fe8b403c37fa46d3d2258517ded1.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR10MB7126:EE_|PA4PR10MB7962:EE_
x-ms-office365-filtering-correlation-id: a5ee17d2-fc89-417b-28ab-08dd3b7e09f4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TGp3bDNaTnNpeG5Qb2NwYjNicjdRWFYrTTF1dEVEeHlXcEFGcytoRGRpVmlJ?=
 =?utf-8?B?Sko0RzVOMEg4WHF5Ny9CMVhDT2c4bUROSms5bXh4V2dQSkxIVWZ6LzFsS1RU?=
 =?utf-8?B?cFRQOUt6TEFEWXlGWUNhS1VRcHdiSVlzQUFnb3k5MzJnWDJ2d1p0dTNQZ2Jh?=
 =?utf-8?B?alFZaE5KT2VGM2t4WmpmUTJzUTFPMG5zSlBTbXo0SlMrb0FGc1Y3R3NoZlRn?=
 =?utf-8?B?T0Q0NFJXUmJrQTM1RGh5OThCa3Y2U2xRNWdqWG10SEowRW0wYjJZelJaR3pN?=
 =?utf-8?B?UmlwV1hCaC9Oc1pwSkZWcGJ6QWxPVWt4WlYzTGt2cnR1L1lVOC9IK21odlpz?=
 =?utf-8?B?bGJnRVRWUWtmQVNDbWFBUUZVbXdaaE54NmoyQ3p5OVlKdm1sWlM5cDZabXY2?=
 =?utf-8?B?K2pMbDQ4amFqZGZwUHlQRDBpUUpUU1JGQlBFc3V2R2tGNXlPdlBFMUxPeE1y?=
 =?utf-8?B?UGdIYnpWWGM4bS9qYzhZV04rcGlpTVpvMTZ1MmttWEVFcEdHME9NTHEvTVdp?=
 =?utf-8?B?bm9FVHJjbHlIaGpLT2h5cnFjYTgzTDUvZEQzTi9rekRnSjJsSG1tZ1YzNzRh?=
 =?utf-8?B?UnduaTNteWtvN29CT3lteGNjL0NneVBpdWt2cGRoaHo4czgwUXpDYllNbHZD?=
 =?utf-8?B?SERIMnRpTXY3QUJrNnFHRjJRd0RLb3lqWk16Yjdvd09XSjhDT2pqVEJEb0dJ?=
 =?utf-8?B?SUZPOWZXRmRDbDhuaXExVWxuNC8xYWtMZjNhNmdPTEozcFJ3Y2N5ZzdudTh1?=
 =?utf-8?B?VTYxZXN6SDY0TEVZT2VxNXNZZWlmYUw4TXFmQXRBUG42QW5kWmsvZWc0MlZW?=
 =?utf-8?B?TVl5VVlvcm0wWDNTMFAzeW5CcHhPRzdYTUY0ei9iUXRyQjFUVGoxbG52cHEr?=
 =?utf-8?B?U0M4T2hpVVpOdVFIK0dlanpKci9hRTdJcHdWakpFa0lDUnMxTGZRUHo2QkpE?=
 =?utf-8?B?V2V5a3BMOGdTNzJuWktObzhHaVF1MytySDA2MVV1QnEwS0g2S0FrVWpzWks1?=
 =?utf-8?B?RjJpS0c5dDVPNVk2TTVRbndRdlpqSkRXdmhiRVRZVS9HejZubVJWd1NGemoz?=
 =?utf-8?B?UERyNjRVMHN6UFByNXQ0eEdVeUZKekErSzF1MitjZ01iM0U0VUpYbDVkR0Uy?=
 =?utf-8?B?aTZ3VkI3NDBkcjZrZXJJaVhJYlpxRklkN1FUaS9wVnpiSmpxc0U5RUoxRm4z?=
 =?utf-8?B?bDNpOXNjR2tYN3REdFcxYUc4cVorSjZzVHBidTUvbGxVTjRlTEZuV2JjRnpP?=
 =?utf-8?B?MmFyeG9MdFEzV0dabUp6dEdVK0hnQWhZdjU4cjlRaGlzdm4zQVlIdmUyN21T?=
 =?utf-8?B?c2dwRkFMcHA2QlMzNTIvNnBvOHpXOXFQWWV5TUQ4RTVHc2UyYnFEMzJLU1Ix?=
 =?utf-8?B?SVNaVE1IcFQzQm1CajlpYldWdXJha3NabHAybTRmNHU1djB0NXpNRktCck1j?=
 =?utf-8?B?VGtJQjgrMUJWMEI0YXFtNGtEcUpzLzdmUDAzMWp4eVFRVGNtU0lCUjRXS0xC?=
 =?utf-8?B?RktzRUZFcm5XYXE4RWJFSGpGR1NIUmdVNDlrV2ZYQ2NDbG10cm0yR0Jxc3BY?=
 =?utf-8?B?RjFxN2JuQ010ZWIvUXdOV2RTQTZsb1JMZ1NrVms2TWpXYjkrcDJhbTN2Q1Jr?=
 =?utf-8?B?R0dPdjBsNzcwZXRXWnJQRmZob3dPZy9JRi9qRFBBYlpwdjQ2em9OL0ZzYVJW?=
 =?utf-8?B?MnRrczUxaHA3SmFNRzB2cU5kU012TkhwcUttdHdqRVRPMkVWS2NxWmJ6cGxo?=
 =?utf-8?B?Z0ZaZ3RwT3Z1NTlnWTVlV25MckJpT1NoaU5aNEhHUWh3VG1rTjMybURGcnlw?=
 =?utf-8?B?RkZkc3N2WWhCSUNlN0ozNHZodDdsK2liMmUxUWw0T2tOT0dmMFhwU3VVSWYz?=
 =?utf-8?Q?XJdxJFTN+Sy+j?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR10MB7126.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VWJ5eG9XYlluSHg2Wmd4RStBR1dLV2pRSFIxZzI0dHpwZmJaWXFqY21vdVdO?=
 =?utf-8?B?TWRGcUwzWlNRL2kxdGF6TENHaCs1T1hXMU9HWll1VXFhOG8zbERBTGF2NDNX?=
 =?utf-8?B?b29maGVNL1RZTE9RcWwzZFRMMVpHVlNwcEo2bksyNkxWeFRrUk9qZ0V2dEw0?=
 =?utf-8?B?U2JSdmJZSFZ6SWZwbFM1NkxDaFNVZUJMcjhWK2hhUkpsM0JmNDlLMXB6ZjlH?=
 =?utf-8?B?VWx3QTcxYTdYMVcvY2xSZnZKdTZDdmUvS3FiVmY5ZE9SdStQczRIT3hiMlFV?=
 =?utf-8?B?R0FvNUorb0w2Z1Boa1dHalVVY0FxNUZaekJTN3VCL2JXTVl4QUhhT0FMM1Ay?=
 =?utf-8?B?bk5nUXhVcktTTkxvV25zVWhFb1htd21JNGRvMGhxU2pUOEhpL2hVcUU3V0dw?=
 =?utf-8?B?b1J3eldRQ1QzTEx3czlVSDFWYitRaFJ1ZjJ2UjhaZHp3YzZWNVJTRkJBRzd3?=
 =?utf-8?B?NTQ2SDZvNGdGREtkek12WVkrVlhNU21sb3FNVlpEVmViWm9BaWt1ZWx2L05U?=
 =?utf-8?B?SVVsNnErdUwzcHVXd1VqbWRGamdtbndWZzlqNzJQdkZJbDhDOG55ZzNYa1Az?=
 =?utf-8?B?cWFvLy9NeGFXTEFleEFUYUVFOUxpUndpdWcxYlRXd21TUnJGRHdYREg4WXpy?=
 =?utf-8?B?Wm9keFIyOXo1RENoNGIzMWtQODhhRzFOSko2b1I1ZW5peU9MOFpoM3hpbHR2?=
 =?utf-8?B?K2svMmtTTldBUHVzR3ZDOGZ4QWF0b0hwaWJqUVc4SXl2b2l2MkZxZnZBYjBL?=
 =?utf-8?B?dXhpcm9hQ3F5L3p4akdkOTQrdGduYVE5d01zUzBGNjRlZ2tJYm9TS1FNNFkv?=
 =?utf-8?B?cGl0L3JrZW9WcHVvZ1l6aEV1YXNUZGF3ZkxmdHIwNmZ6eFI5MmZ1OHNIc01p?=
 =?utf-8?B?ckhCNFhsc2dUS2cwMlBIVHQ4dDRSbHJaKzVhUFRFWFFJeFo3UGxkNXlKQ253?=
 =?utf-8?B?YmttdGpJdXdQcTN0czYvc2xaTUZUTGx6QmJReTllQVVqOVZNVVZKaU5xMHAz?=
 =?utf-8?B?Q2dUQXloTGtuRlorN0t5OUZQUVlIczhnZUs2RHRnQURhRkQ2cEtIQXBZOS9u?=
 =?utf-8?B?b1l3eVpBaFZORm1adVM0VThHNk9rTS9ML09zVmhaUUdKNDE3TzlnUlhxd0VW?=
 =?utf-8?B?SzVYeG11UXdoL2lvY0k2MG1FU2IxOEV5U1lYK250SUpHWEdCTHhMakdmcjFN?=
 =?utf-8?B?dHJRK1VMZUMwYm1QM0Fkd2oxTURiaHVWZCtwdDNkWGx6Q3hvS0UvY3AybjRR?=
 =?utf-8?B?aW5pZk9TdlV5NElxT05BVzdMUytNVHJZZ0hNV1QvemVGVTdKWTE2ZU16cUl0?=
 =?utf-8?B?c2doRGpBNjRNanArREhhQ1J1Skc0TFRLYTBKUm5mQW1KdUN6RFkrTjJvV1o0?=
 =?utf-8?B?UGtEOHpPbjRYNUp0YTFldndGeDlVTFQxVEc5Zk16M29DTGR0M2VuMjZndnIw?=
 =?utf-8?B?b0VpdGFmd0h1RkNOdS9VMGhaaFhPYWdxaW5wcGsxeEhLZzRXRXprcDgya1Jk?=
 =?utf-8?B?OVNKZTR6M0dwZFVKS1VRWng4U2F0bkxMNlBmY3NrRmVjcW5XU0hYcHBObHd6?=
 =?utf-8?B?ZlorTW1yS0JQYkNMNjdmUnA0ZnYvRGpONS9VSm1EcUR0bUNuckppb2NwRmVn?=
 =?utf-8?B?Zkt5U1FaRXYzbVkrMUs3MTlYNDZkd3N4blNqUDdaRFJuS29BYzlsWlJlQjYy?=
 =?utf-8?B?ckdSSUdJcFVzQjNQY3lIdU1TWjF0MktJNnJQL0dJVkpHVFY3b0MyN0QrWlFn?=
 =?utf-8?B?VXE2b1ZwcFhOQ0kzbEU3bXRpdE1YTUJ6OE0xbk54bFB0N1dTTS9pWWprSk1n?=
 =?utf-8?B?QXdBQ3N2VTlsQWYrVFJsenVLTnBLbzFoUEo2UEU4eVNiaUQ3TGVxYndHbkkv?=
 =?utf-8?B?WC9oOXM1aksyMnVYY2xtc2ovZTNVaWNQNVNqQjNEQzVtR3MrYVJFU3lOaklV?=
 =?utf-8?B?cnlXcEp4Q2g3ZFdNQlQ3YlZ3VlZoZitOQ3hTbzJWY0h1NFhmckRicWVrZEJk?=
 =?utf-8?B?SXNSd3ozQ21yS3RRYjR2UmNIaWp1TG02aVlPY1FYMy9hV3NScDNsSHdmWXRY?=
 =?utf-8?B?alU1V1lqVndqQkMrck15UnJuL1dWTDgwRDJ3VWhBSlpGU2FGaGlFRWpVT0ph?=
 =?utf-8?B?OW1GN2VZbk9XWXRDQ3pveGdHcGRUenZrK2x1MVExVEhsTmovUGlPbERSZDJC?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91AE589016750E42AB5F6F49F69C377B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR10MB7126.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ee17d2-fc89-417b-28ab-08dd3b7e09f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 07:17:47.5025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fl8Zd4eAbaYv+qz4L4E58hh28sFPp+SJrrHIsMr1RuQRMnE7MMxPi6sQsrulCEsaf0yKOsFT9fUKFghL8QYT9FVvUvUFIDu0uwcoj7jUL80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB7962
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jan 2025 07:17:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17603

RXh0ZW5kIEZJTEVTUEFUSCB0byBtYWtlIGluY2x1ZGUgZmlsZSB1c2FibGUgaW4gb3RoZXIgbGF5
ZXJzDQoNClNpZ25lZC1vZmYtYnk6IEx1ZHdpZyBOdXNzZWwgPGx1ZHdpZy5udXNzZWxAc2llbWVu
cy5jb20+DQotLS0NCsKgcmVjaXBlcy1ic3AvdS1ib290L3UtYm9vdC1jb21tb24tMjAyNC4wMS5p
bmMgfCAyICsrDQrCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL3JlY2lwZXMtYnNwL3UtYm9vdC91LWJvb3QtY29tbW9uLTIwMjQuMDEuaW5jIGIvcmVjaXBl
cy0NCmJzcC91LWJvb3QvdS1ib290LWNvbW1vbi0yMDI0LjAxLmluYw0KaW5kZXggNWEwMjBkYS4u
N2YyZDYxMSAxMDA2NDQNCi0tLSBhL3JlY2lwZXMtYnNwL3UtYm9vdC91LWJvb3QtY29tbW9uLTIw
MjQuMDEuaW5jDQorKysgYi9yZWNpcGVzLWJzcC91LWJvb3QvdS1ib290LWNvbW1vbi0yMDI0LjAx
LmluYw0KQEAgLTExLDYgKzExLDggQEANCsKgDQrCoHJlcXVpcmUgcmVjaXBlcy1ic3AvdS1ib290
L3UtYm9vdC1jdXN0b20uaW5jDQrCoA0KK0ZJTEVTUEFUSDphcHBlbmQgOj0gIjoke0ZJTEVfRElS
TkFNRX0vZmlsZXMiDQorDQrCoFNSQ19VUkkgKz0gIiBcDQrCoMKgwqDCoCBodHRwczovL2Z0cC5k
ZW54LmRlL3B1Yi91LWJvb3QvdS1ib290LSR7UFZ9LnRhci5iejLCoFwNCsKgwqDCoMKgIGZpbGU6
Ly9ydWxlcy50bXBsO3N1YmRpcj1kZWJpYW4iDQotLSANCjIuMzQuMQ0KDQoNCi0tIA0KTHVkd2ln
IE51c3NlbA0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

