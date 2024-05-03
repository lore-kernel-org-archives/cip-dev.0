Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE2AC25B74
	for <webhook@archiver.kernel.org>; Fri,  3 May 2024 11:47:28 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.76])
 by mx.groups.io with SMTP id smtpd.web10.9985.1714734889698662483
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 May 2024 04:14:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Nnoll4iM;
 spf=pass (domain: siemens.com, ip: 40.107.20.76, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNXeC/K8jODYD4GMDQqUDjakj0AGyx0CUwxehOTXrm30JwFN+vANKKQIn6p/JAytMdjdW7odvZOiI9olTdiu4unTJkgk3sWaWtd/l8CsiPAy0x2kmLWmqrwnQLf3Sf3cFobb3MhEtaC6nJNihPS2DU0HWdPyDzuzrWHJnSBi4jwvySJzK19Spk4lFmEl2VjYl59yGVN+s7/zqTaWxUooTRzG9AyanBH0/ju1WjFHV4szNT2Sw3fskVI7GbjotruMzFuAN2BSfb6nozSojulIHRi0LsXiBr8jec5tctFSCv/Y0q7G24h6SxuyPmlOngkfQUSh/NP4Bu9LXQWCf1cDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fo+NkLnvzuFMK4SUquqyCK0MvU4Bs30/t9YP5NWwTwo=;
 b=EujnQ4Lw7wLqNe1wh7feY06DPWDPCvTDfY26C5HrVa+ZkmtBNGQpTIw++vVGv3+rsaPjK6Y2LNo5XYNnlSQmOUlw7m1Z0YA6p5j1Lv9G8ivKph6uRxbBfpcgbyAwLrqbxDIEPbZvu9FDr6eBosW7LfJUqnCJnzILdemwk2ZVwkvZZCZzZK84wJA0jwtetVHeKsa3gD8W2x94M40KI/eYidvYa9mHwQvFFjnUYSj/Lloyj7rjs5N4Jkm/sqRHmRTglKeCaEIiBfr5Cre1ZI6z/qQOxVA846HfdNTWi8TmD5mdzDV8FcNrYAwdEWVZo/okfTyJVR4k3jIorvQsm31G9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fo+NkLnvzuFMK4SUquqyCK0MvU4Bs30/t9YP5NWwTwo=;
 b=Nnoll4iMG2E/7Z5knygz4YF66wFn8hbNBtnfF7R11MZ3Q+ghFqQyVAXIIC/EiObXWsTbPyRQZdtg/8wTr1S4HRXiSyMTGr1dNXwdQ3DCBd36ocUh0PLZc41tVtNWRcZiVZxYY7UgS86DIsp30Bcvazo3PaSDclRMD90cjDjPyL7yo8auGp19avZESc5oYtrq4AzIvJNOBTzEIEyYJR0d0V+eGdXBQogovjb3U1PJEbvaOG2LF92V8zzaDcpC0Lu3mD1VATxT4VbHkpvfLUOHn9lBoiCbOSAtRKUe53XOtVUWO3WiAw989OzPDvN7Kb7RxSQQDtGfqn+KRKL+2VHC7w==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AM8PR10MB4067.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.31; Fri, 3 May
 2024 11:14:46 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 11:14:46 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "johnxw@amazon.com" <johnxw@amazon.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 8/9] README: Add rootfs encryption
Thread-Topic: [cip-dev][isar-cip-core][PATCH v4 8/9] README: Add rootfs
 encryption
Thread-Index: AQHanHOwwBQuXphvb0O+8EYIeARdVbGFXU2A
Date: Fri, 3 May 2024 11:14:46 +0000
Message-ID: <00ed9715b70a92c7929a922b4f8881d3d9e4a467.camel@siemens.com>
References: <20240502093240.364093-1-Quirin.Gylstorff@siemens.com>
	 <20240502093240.364093-9-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240502093240.364093-9-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AM8PR10MB4067:EE_
x-ms-office365-filtering-correlation-id: f5856095-2625-4a6c-6953-08dc6b623da3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?d3pjeERBQlFTS2ZYNWErb3c4RU9SMStBaW9yUU1Zc0MwMll5M0tvMlI3b1Ar?=
 =?utf-8?B?bGZOLzhqL1NzS05waU9JNnRGeUxKWExzdS9YUlVtak5PYnZ6VnZRRHVQdVc5?=
 =?utf-8?B?OGVDbTNHbENCTDkwaUQ0Ni9nVEdFU1hOU3FRb3hRVVFKeS9TVGEvbWthc2xq?=
 =?utf-8?B?eXNiRDJxZVJ0aXdZQUlwTVpQcnRJcE1RTTRqQmVlMjZQREoxSUUrM3UyY0ht?=
 =?utf-8?B?LytWVXF4T1p0d2FmeTFacXNuSDdjZjUvTzdaWlA5M0VaTGRoVGJjbkw4OHR1?=
 =?utf-8?B?WDZlU3B5Z2VkeXNGcXppWEhINmExdk5sMmxiUmJvWTFlcHc3ZWxQOFNKR0k3?=
 =?utf-8?B?ZEVKZ2ZJTzZ1UEcyaFcvRWsxbzNTTVpsYlBaL041RzlXNk04cjV0UHEwaW5s?=
 =?utf-8?B?SUNhUm1HMFdXYVJQZUVxWFpPdTFSUUk3ckE5QkgzaVhxUEhGa0FzbXhlQ2hk?=
 =?utf-8?B?VXJXeEQvaGVjUTlmUXZyRlVTdUVncjRHWmwzVGlyRTFyRm9naHhNWUJmTUpl?=
 =?utf-8?B?NXJGejFBRW1aVzhhZGkraUZScE9LWnhudTFBUENkSXBtbnNpNmtjUnM2VmdY?=
 =?utf-8?B?OVVrVjAyc0p6TTlJcjVvME8xWDFxd0FtUmZ6c0JsMGJyNVZLZkQzWDhMNi9X?=
 =?utf-8?B?UkNkNVNjTjFPZ3Z6b3diZkRFbTE2eXQzUGUrZURHRjNrajJuQnR4OG9RSEFV?=
 =?utf-8?B?d05YblNmV09LQUgrdHVJd29yT3JpQVpOUWJiT1hHVmVRVlh1TTZYK2NyWnlG?=
 =?utf-8?B?Z1M5alVUZURPSXh0N2tuSy9jQUwyL2pscUIyYUlhcWJDanNJcGxXWThlQlQr?=
 =?utf-8?B?WU1YQVVJME1vUUxBdVFvalBQWFBPckJYalNHR0dMcFBzM1FiUkxBYXJ3amdM?=
 =?utf-8?B?ME1VYVRRcmV3VEtTQU1TUWpTVlFDbHo1RFBxQVdmN2ROUmViM09XbzNtNllZ?=
 =?utf-8?B?WmhyRUZpQ3lFSjhmUm41UTFOY2VlTUViSEw2NTh4c1dXdDUvQkJVejQ1UU4w?=
 =?utf-8?B?c0ZpbGdodGViTlNVVGdEWW9BY0FuWDNRVFFFd0JYSGRrZW1ZZ0hpZ1lEMTN5?=
 =?utf-8?B?NGNwWFg3ZU9IVDRQRzRHM1l5OHNLV21yRzdXdHY5QWFiRXRrNU1oTGV0MURh?=
 =?utf-8?B?ZnVGQWlXTjEyTXcrWm9BVy9scFJwZjRoUHZDcmdlZFgyaFNEdG94a096RVQ2?=
 =?utf-8?B?aU1rVm1zTjZEWTNTVkV6NWZGQTVoQnNENUVvU2ZiUUg1a2RTZDArbEtHRUZr?=
 =?utf-8?B?M25wSVJxS09rM0FqcFB6MHJIMXYvMllOMURwQzFtZi95NWthODF2cUk4OVg0?=
 =?utf-8?B?M0QwNzBPdUNjN1BaVFBVQk5LQkpRNUV4T2JtdUYzZUl5SHJlYmZhdEFBSFZw?=
 =?utf-8?B?eFZucmlhbDhFNEpLeFF2MHVWZXBWY3hYZXI3K1JpS0tUa1drbTZhS2psTnMy?=
 =?utf-8?B?bGtmaHBSNkw1ZE5MdDFyeG9RZTdCU01SdGJCUzVNWGpKVWFRK1Fkb01yeWFF?=
 =?utf-8?B?TTBtcHZGejdmelY5bFF0bkgwVlNlREtBaVdxZjVOMXJMcEtMZmJKVmdqcExZ?=
 =?utf-8?B?aEJzTDBhOFQvb2FQeW55M3V6clJoUk8yTjM3OWo1YlM2K1RyajZ5a3NwOXNl?=
 =?utf-8?B?cGM2OVpTT2c5R1hEY2t2dEk4Y1Z3M2VFdWlvQ1BtN3g4UFBCOFI5WEJHWWJK?=
 =?utf-8?B?QS81Q2RPcENiaFVQaEhuY3MwZDBpc3ZXOEp4cm1XUUhQeDU1TzEvcVlsZEEz?=
 =?utf-8?B?QjZoOWRNTGpJZjcrRlFIVzY3bWZuZzJPd2RpNWM0M1hGK0VmZG9Kbjd2SXZC?=
 =?utf-8?B?ak9ka2tKU0k1OU5qUjc4UT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Q1RDRGtyVjMyd0dsdlhNWlRUNnNYOEF4eFc3RnFoM0VYSW5xSElwbGJ3L2JF?=
 =?utf-8?B?VUVKRWp4TnpIY3NVbzlBelVuL2Q5Z1J0eFNNS2hjWGhoaFpXRTJpdXN5TDk2?=
 =?utf-8?B?azFVbDlTQTBUeEdadnhrRWtmemd2S1B3T0s1bnZwU0g1cVpENE4zVkhydHNv?=
 =?utf-8?B?dkFZdlI1dmE1dm4vRFVScFNBWnk4Um1ZWjJHMkErNzZXTHdVd0pLaUNFUWpE?=
 =?utf-8?B?cGdJWjVoNEl3QUhvZHNaMVZURElYR2RYTjNQWFVCUVZNR2gxV0ZnbjZZb0Vu?=
 =?utf-8?B?YnNYeXV5bzN5T2VWNVVmMk4xMnRuOGp4b2IzN01pdk1tSGpEbkRETWQ1VlRN?=
 =?utf-8?B?NnNmT3RDME5jNW4vVTl6VXRLWmNLVUF2K1l2SnQ2b2NxaUFkK2M4Zk5DU0Rz?=
 =?utf-8?B?dkFrOHZsa3JnVWhxUEtCQmFUSktPQUxpdUczNER0bGFPSDMrdC9VRTNHRXpT?=
 =?utf-8?B?NVI5Q3loWFk0bm91WmY4d1lVNUZVaDRWeWRaOTZHT3RJK3ZBZnVZRkRLUk94?=
 =?utf-8?B?a00wT2NNQjVoeGFLdjltbFhoQ1pNZm5xYVpuQzE0UUdOK0JQY2xxaDJDRTBT?=
 =?utf-8?B?d21WMG16U1Y5UEpaWWZmalI5SGVvUDdYVUQzaHBPUlkvREhNYzhJTlprS2NH?=
 =?utf-8?B?Y29TQ3NrSm96WkdGZ0RlZ1orRkNPUVpaMmlwK1ZNTVQ2VUVDaGcwNHVFUERO?=
 =?utf-8?B?T2JKZWtzekc3L2w0NENWU0d0Q0xEM0luckJtYnVaZCsza2g3bWR1N2lDWFNP?=
 =?utf-8?B?SUVTNjlMVTFtekcvZHp2enRrQzlsbEZYZTBOVmgxN0R1ZnJkYW4vYTAxUkcr?=
 =?utf-8?B?MnhtbGMxQ0srSytWaXE5YXYrV0NxeU95aFR4ZTZ3SEtYS0wvTkh5bjQwUE15?=
 =?utf-8?B?alhIZFd3dlh2aUxUVENiQ3JsQWFJaHZRU0FORGg1RE5yY3VVNkRlRERnZWxt?=
 =?utf-8?B?OGtCajdKMHZMdWxPeVFBMHNvOUtkaUh5aWZxVVZFY0tSZkJrTWljbU5HS0Vq?=
 =?utf-8?B?ampqcEdVY3J4dmN2VjJ0NlEzbmdEcFlldGdjSXNoc1RHcW5hZ3NDTVVzSCtT?=
 =?utf-8?B?RzZMQ28rUCtPRE1WSCsvQUdDREVnVmYySWVLYTlVVkMwWStiMG00cktwUFQr?=
 =?utf-8?B?emNLdGdGUUNodnljTEVkeWdLaTBTdnZrVjJVQkR4YzQ4R1NPTDNCNUQ3c2VV?=
 =?utf-8?B?dTFlVXZqVkNhVlplbllXZFlnRkZtNHdZZlFYeXNFeFVJd1c1Qi9PWmNPbk1X?=
 =?utf-8?B?dGp2Um5EVkdkd1dDS1lHVTJYTklUS0hCWnZSWG04VHFyVnUzcFc5Z1Z0am5h?=
 =?utf-8?B?SWttbE54M3VpVm1CdUI3R2ZxQ2ZSQkxnZy9tV2R6VEczY1pZZGJjMWtKcE80?=
 =?utf-8?B?aVN0WUtEQTJpaUtUcHJlK01Ia0J5dFplSGxnRDJkMmc0NzloSjR2T0tHUHVK?=
 =?utf-8?B?LzFxZkZXMXBmWDVaOXFJTVVKbXVEcHdIWFF6QnNMMURjODJhRUpmYmNYOGFi?=
 =?utf-8?B?UnQyU1dBYUxmaDM3U243V251OXprUFF3cThlaVpleDNhbXc4TVMrU1NKaW5w?=
 =?utf-8?B?T1dJck1TVllGamVVTTgwSkNzZ0RaZGwxa1JGYWdDSUZEZ1F5UjJ4Zmc1eXJ4?=
 =?utf-8?B?eTc5STF3a3Y2VVlQWVR5VFZ5UGQxM1I2MU1TQXdGMXNSN3VVR3JpaVk3cENX?=
 =?utf-8?B?QVdCSnFwTXVWUy9wR3F5RE4yUks3SGJhSklUVmZWTWg2dUN5VFpCekJpV3Ja?=
 =?utf-8?B?KzVJWmpXSUh3cVNLdVJlUlNwQmJnSnpIbWR2V3ZWQmdVbW0zK2sxaUVzazJo?=
 =?utf-8?B?dFZHckczd29tSVppS25sQ2RwVzlwZVlGR3pGL0t2VXUrNTBOUFBiSnVGUkha?=
 =?utf-8?B?Qnp0N3Y4dUFNaGNndlVWcVl3MjR2MElZSVhKSThEdzJwcytPUjFTTVBPL3dj?=
 =?utf-8?B?Y2ZOa29kUU5wZ3Z3d0I1WWNPaEJmVVplY0VqbzBRNTFDS3VPYm94Z09vMlQ0?=
 =?utf-8?B?eUZqKys2bW1IMXg5dG0vMldzTm5pK0FELzdTYjQzRjVqTHZqMGdVOXp0MHhN?=
 =?utf-8?B?akdIcmZwYTJkcGpYdTJxWXQ3Mm5OTE5EeitPeTZyVlBVV2l2c0RiYXJqRTFr?=
 =?utf-8?B?TzhFdVk2TXVRdytCMmo1WGo2WmNpVzNPUXcxR0ZuWWROb0VPb2lKY3grYk85?=
 =?utf-8?B?OUNmSnhLYjFWaFVWd01YbksrZnlEek94TmQrZ3FhcURsV1NRVjRPYlZOMjkw?=
 =?utf-8?Q?OhRZBr1B6wJJAmPRkUFNMykDOTfrC2J1CBzsRnUKLk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f5856095-2625-4a6c-6953-08dc6b623da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 11:14:46.4755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: prkoDnEi69epA3e1iFvlMxWEej9iuRClFFPZcPgWxvGTlnLpzfxfYckv4LgbdJ2LccS5Q4+65nBHJoEMALZ8oZSHBDV07Ff2ZBMmG6Ja6DA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4067
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <00633F01F5A9F844A94CA11B1EE4780F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 May 2024 11:47:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15820

T24gVGh1LCAyMDI0LTA1LTAyIGF0IDExOjMxICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3Jm
ZkBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+IMKgZG9jL1JFQURNRS50cG0yLmVuY3J5cHRpb24ubWQg
fCAyMCArKysrKysrKysrKysrKysrKy0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RvYy9SRUFETUUudHBt
Mi5lbmNyeXB0aW9uLm1kDQo+IGIvZG9jL1JFQURNRS50cG0yLmVuY3J5cHRpb24ubWQNCj4gaW5k
ZXggYzVhYzZjNC4uODg5YzNjYSAxMDA2NDQNCj4gLS0tIGEvZG9jL1JFQURNRS50cG0yLmVuY3J5
cHRpb24ubWQNCj4gKysrIGIvZG9jL1JFQURNRS50cG0yLmVuY3J5cHRpb24ubWQNCj4gQEAgLTQs
NiArNCwxMCBAQCBCeSBhZGRpbmcgdGhlIHJlY2lwZSBgaW5pdHJhbWZzLWNyeXB0LWhvb2tgIHRv
IHRoZQ0KPiBpbml0cmFtZnMgYnVpbGQgdXNlciBkZWZpbmVkDQo+IMKgZW5jcnlwdGVkIGR1cmlu
ZyBmaXJzdCBib290LiBUaGUgZW5jcnlwdGVkIHBhcnRpdGlvbiBpcyBhIExVS1MNCj4gcGFydGl0
aW9uIGFuZCB1c2VzIGEgVFBNIHRvIHNlY3VyZSB0aGUNCj4gwqBwYXNzcGhyYXNlIG9uIHRoZSBk
ZXZpY2UuDQo+IMKgDQo+ICs+IDpleGNsYW1hdGlvbjoqKklNUE9SVEFOVCoqDQo+ICs+IEFsbCBz
ZWxlY3RlZCBwYXJ0aXRpb24gYXJlIGVuY3J5cHRlZCBvbiBmaXJzdCBib290LiBJbiBvcmRlciB0
bw0KLS0tLS0tLS0tLS0tLS0tLS0tXiBwYXJ0aXRpb25zDQoNCj4gYXZvaWQgdGhlIGxlYWthZ2Ug
b2Ygc2VjcmV0cw0KPiArPiB0aGUgZGlzayBlbmNyeXB0aW9uIHNob3VsZCBvY2N1ciBpbiBhIHNl
Y3VyZSBlbnZpcm9ubWVudC4NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1eIHNob3VsZD8gSSB3
b3VsZCBiZSBtb3JlIHN0cmljdCBhbmQgc2F5DQoibXVzdCIuDQoNCj4gKw0KPiDCoCMjIFJlcXVp
cmVtZW50cw0KPiDCoA0KPiDCoFRlc3Rpbmcgd2l0aCBxZW11LWFtZDY0IHJlcXVpcmVzIHRoZSBw
YWNrYWdlIGBzd3RwbWAuIFVuZGVyDQo+IERlYmlhbi9VYnVudHUgdGhpcyBjYW4gYmUgaW5zdGFs
bGVkDQo+IEBAIC0zOCwxMiArNDIsMjIgQEAgVGhlIGluaXRyYW1mcy1jcnlwdC1ob29rIHJlY2lw
ZSBoYXMgdGhlIGZvbGxvd2luZw0KPiB2YXJpYWJsZXMgd2hpY2ggY2FuIGJlIG92ZXJ3cmkNCj4g
wqAjIyMgQ1JZUFRfUEFSVElUSU9OUw0KPiDCoA0KPiDCoFRoZSB2YXJpYWJsZSBgQ1JZUFRfUEFS
VElUSU9OU2AgY29udGFpbnMgdGhlIGluZm9ybWF0aW9uIHdoaWNoDQo+IHBhcnRpdGlvbiBzaGFs
bCBiZSBlbmNyeXB0ZWQgd2hlcmUgdG8gbW91bnQgaXQuDQo+IC1FYWNoIGVudHJ5IHVzZXMgdGhl
IHNjaGVtYSBgPHBhcnRpdGlvbi0NCj4gbGFiZWw+Ojxtb3VudHBvaW50Pjo8cmVlbmNyeXB0IG9y
IGZvcm1hdD5gLg0KPiAtLSBUaGUgYHBhcnRpdGlvbi1sYWJlbGAgaXMgdXNlZCB0byBpZGVudGlm
eSB0aGUgcGFydGl0aW9uIG9uIHRoZQ0KPiBkaXNrDQo+ICtFYWNoIGVudHJ5IHVzZXMgdGhlIHNj
aGVtYSBgPHBhcnRpdGlvbi0NCj4gaWRlbnRpZmllcj46PG1vdW50cG9pbnQ+OjxyZWVuY3J5cHQg
b3IgZm9ybWF0PmAuDQo+ICstIFRoZSBgcGFydGl0aW9uLWlkZW5pdGlmZXJgIGlzIHVzZWQgdG8g
aWRlbnRpZnkgdGhlIHBhcnRpdGlvbiBvbg0KPiB0aGUgZGlzaywgaXQgY2FuIGNvbnRhaW4gYSBw
YXJ0aXRpb24gbGFiZWwsIHBhcnRpdGlvbiBVVUlEIG9yDQo+IGFic29sdXRlIHBhdGggdG8gdGhl
IHBhcnRpdGlvbiBkZXZpY2UsIGUuZy4gYC9kZXYvc2RhYC4NCj4gwqAtIFRoZSBgbW91bnRwb2lu
dGAgaXMgdXNlZCBtb3VudCB0aGUgZGVjcnlwdGVkIHBhcnRpdGlvbiBpbiB0aGUgcm9vdA0KPiBm
aWxlIHN5c3RlbQ0KPiDCoC0gYHJlZW5jcnlwdGAgdXNlcyBgY3J5cHRzZXR1cCByZWVuY3J5cHRg
IHRvIGVuY3J5cHQgdGhlIGV4aXRpbmcNCj4gY29udGVudCBvZiB0aGUgcGFydGl0aW9uLiBUaGlz
IHJlZHVjZXMgdGhlIHBhcnRpdGlvbiBieSAzMk1CIGFuZCB0aGUNCj4gZmlsZSBzeXN0ZW0gYnkg
YSBzaW1pbGFyIGFtb3VudA0KPiDCoC0gYGZvcm1hdGAgY3JlYXRlcyBhIGVtcHR5IExVS1MgcGFy
dGl0aW9uIGFuZCBjcmVhdGVzIGEgZmlsZSBzeXN0ZW0NCj4gZGVmaW5lZCB3aXRoIHRoZSBzaGVs
bCBjb21tYW5kIGdpdmVuIGluDQo+IGBDUllQVF9DUkVBVEVfRklMRV9TWVNURU1fQ01EYA0KPiDC
oA0KPiArIyMjIyBFbmNyeXB0ZWQgcm9vdCBmaWxlIHN5c3RlbQ0KPiArDQo+ICtUbyBlbmNyeXB0
IHRoZSByb290IGZpbGUgc3lzdGVtIHRoZSB2YXJpYWJsZSBgQ1JZUFRfUEFSVElUSU9OU2ANCj4g
bmVlZHMgdG8gYmUgc2V0IHRvOg0KPiArYGBgDQo+ICtDUllQVF9QQVJUSVRJT05TID0gIiR7QUJS
T09URlNfUEFSVF9VVUlEX0F9OjpyZWVuY3J5cHQNCj4gJHtBQlJPT1RGU19QQVJUX1VVSURfQn06
OnJlZW5jcnlwdCINCj4gK2BgYA0KPiArVGhlIG1vdW50cG9pbnQgaXMgZW1wdHkgYXMgdGhlIHJv
b3QgcGFydGl0aW9uIGlzIG1vdW50ZWQgYnkgYW5vdGhlcg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tXiBhbg0KaW5zdGVhZCBv
ZiBhbm90aGVyLg0KDQo+IGluaXRyYW1mcyBzZXJ2aWNlLg0KPiArQm90aCBwYXJ0aXRpb25zIGFy
ZSBlbmNyeXB0ZWQgZHVyaW5nIGZpcnN0IGJvb3QuIFRoZSBpbml0cmFtZnMgb3BlbnMNCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tXiBob29rDQoNCkZlbGl4DQoNCj4gYCR7QUJST09URlNfUEFSVF9VVUlEX0F9YCBhbmQgYCR7
QUJST09URlNfUEFSVF9VVUlEX0J9YA0KPiArZHVyaW5nIGJvb3QuDQo+ICsNCj4gwqAjIyMgQ1JZ
UFRfQ1JFQVRFX0ZJTEVfU1lTVEVNX0NNRA0KPiDCoA0KPiDCoFRoZSB2YXJpYWJsZSBgQ1JZUFRf
Q1JFQVRFX0ZJTEVfU1lTVEVNX0NNRGAgY29udGFpbnMgdGhlIGNvbW1hbmQgdG8NCj4gY3JlYXRl
IGEgbmV3IGZpbGUgc3lzdGVtIG9uIGEgbmV3bHkNCj4gQEAgLTU5LDcgKzczLDcgQEAgYmFzZWQg
ZW5jcnlwdGlvbjoNCj4gwqAgLSBqcQ0KPiDCoA0KPiDCoCMjIHN0ZXBzIHRvIGNvbnZlcnQgY2xl
dmlzIHRvIHN5c3RlbWQNCj4gLVRoZSBmb2xsb3dpbmcgc2NyaXB0IHNob3dzIGhvdyB0byBlbnJv
bGwgYSBzeXN0ZW1kLXRwbTIgdG9rZW4gd2l0aCBhDQo+IGV4aXN0aW5uZyBjbGV2aXMgYmFzZWQg
ZW5jcnlwdGlvbjoNCj4gK1RoZSBmb2xsb3dpbmcgc2NyaXB0IHNob3dzIGhvdyB0byBlbnJvbGwg
YSBzeXN0ZW1kLXRwbTIgdG9rZW4gd2l0aCBhDQo+IGV4aXN0aW5nIGNsZXZpcyBiYXNlZCBlbmNy
eXB0aW9uOg0KPiDCoGBgYGJhc2gNCj4gwqBleHBvcnQgZGV2aWNlPS9kZXYvc2RhNg0KPiDCoGV4
cG9ydCBrZXlzbG90PSQoc3VkbyBjcnlwdHNldHVwIGx1a3NEdW1wICIkZGV2aWNlIiAtLWR1bXAt
anNvbi0NCj4gbWV0YWRhdGEgfCBqcSAtYyAnLnRva2Vucy5bXSB8IHNlbGVjdCggLnR5cGUgPT0g
ImNsZXZpcyIpIHwgLmtleXNsb3RzDQo+IHwgZmlyc3QnIHwgaGVhZCAtbjEpDQoNCi0tIA0KU2ll
bWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0KDQoNCg==

