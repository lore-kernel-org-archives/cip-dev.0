Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB7DC3DA5D
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 06:24:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.30126.1721888647955906811
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jul 2024 23:24:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=E8BvrXNC;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1721888639;x=1723098239;bh=/3RSZxar6oIY2mptw8PEnOLa8NiR68XgbBEPDSf
	CPPg=;b=E8BvrXNCOcfb5RkN7uEDweJVG/jDlHub5UTWTF9xfWiFvdaQ3Ky06sQP5W/dEN1KHo8az
	Y+KbhJ0Wmj8xX3ys9dFqPPWr1wmcEOqg456B2a48xvO4Bk/k9RkA5hI3A1OxD/hmBHcyooWO59vP1
	C0s6T1Fz7moN9lu4QVlPPAHqrjOSjeEXpenMBzihn21DBgV1q2O1fAtxrOJXDrNWbzfUGAHuKbCaM
	2Zwihx9AmBDdxlnsc5vNeisQPJastcOmShUJCEozACPjD/+ob6+klBV/nzEX5xuZ4AmA0CDvTDUr9
	mqywgLwNeURE22cSHzlFPyeAjpvT+sgELvo7hjX1YQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 46P6NvuR2021497; Thu, 25 Jul 2024 15:23:58 +0900
X-Iguazu-Qid: 2yAb5mQqVIrmiGtCV9
X-Iguazu-QSIG: v=2; s=0; t=1721888637; q=2yAb5mQqVIrmiGtCV9; m=+jTOArt8iqOt51R072UtwfiD8+RN5zmdnc/M12CJRjU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 46P6NuwG2377691
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 15:23:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkVrFqYH2E7EK3TlLwn82pjDw46kywyxeUpC5t5geAk2WHlPCgD2PD6R2QLf35+bM2ud4YqxGJ5q2b4ON7pj8/+TX9HAlLfhMbkVBNrWa8FurqwsPu/kDGQteAHJbWtGnH6dO+Fxq74HgKkQhz4PNQ9e3jRlWHnOZg2ocxFXljLyS1Obnl4KqLuWurOqEJfTIIHfp50yFNxx56MYGfyCsZRwJx6sLDr4uYfm/rMRcuBCyy/ODFqyiW8268Ba9nCojHtWucs3TxehRuFnLklaV/wIDWv8/bf9JzQFkO9luPmtoqyvr4kQbCi4FOKrPkDqDd6OHGiP43Q/FPRm+2jj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3RSZxar6oIY2mptw8PEnOLa8NiR68XgbBEPDSfCPPg=;
 b=BERfdlQsBVqSV+Iwafe+5yAolPRhby2jooECj7tEDOhp1eaHTYsLM2rNoi+oa6WEXo4Gp3RzPhA1h9oxLD2ObaHrZmY5hnyDCwcZv3ie97M9CLGNDCnTC3l5Q7SXJF5I6rJjF41DaFtlmSKDEbV9fMbbh2H+avazPH9iGSBCkTG6z4meGVCXSePAkV1wO62FaLYTAo6ovBLgl2e70dOWJ0b+fT70Kof1SMfZaHt9zL+MSc46BKyQ/VYRXkj13wrRuCJwz96in3zTztRYIilSdmExHuchUx5x1KTWC7KR3gQGnmQbas58eWO66MpyCBl5ugNn1ruyW0jcgYn0t9/eIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <paul.barker.ct@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/11] Backport ravb driver improvements
Thread-Topic: [PATCH 6.1.y-cip 00/11] Backport ravb driver improvements
Thread-Index: AQHa3Z+dCx5tgM/X30ORdpjx0AxTjLIG+hNw
Date: Thu, 25 Jul 2024 06:23:53 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388F643074689B3B7F3D1DF92AB2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240724080046.1500825-1-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240724080046.1500825-1-paul.barker.ct@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB9472:EE_
x-ms-office365-filtering-correlation-id: 5184d087-0bf9-4242-52b7-08dcac725b3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?OXVhY1dxTjhRWHVPRWx4V3AzUms0bFpkWGR3MTZqeGwrZ3JVTHBReFMwbENS?=
 =?utf-8?B?QzRMYVRWTkIrN1RoVEZZSkZ1VHJxb0c3a2NUL0F2Kzlzdi9GSFhBV2hEWi8w?=
 =?utf-8?B?cmZYem91LzdjYVJPU2hoZlg0bE5QR0JKazhMUyt2eGlJWCthc1haVVZtbXdI?=
 =?utf-8?B?c1hrWTl4UDZoVXV1MTFZU2kwSkVqUkJSYlAvb2twTU1QQzJwcWtnN0F2bFJn?=
 =?utf-8?B?Uk9QSndYZ1NwVGNLaHdyQTJCUUNrRS92UjVkZ0RBL2Z1ZHRUNmVwM29YNm5l?=
 =?utf-8?B?WTJjQTQ5RkswSFA4UHQ1L2VrRXQ3Yndvd2RHK0FsS0hOcmg1OTJJMVl3UEJS?=
 =?utf-8?B?Rm1wblRZd0VIMTFBY0FoRitWYngrbnlOR1piTkZITTRUQ1VmS0pLNzVTUXlk?=
 =?utf-8?B?K09VVjdOQTBiZjR0VHYyZ1pqZ2tsdXhBQThxcEM5ZmZNbHl3dFNzTVhkWjVO?=
 =?utf-8?B?aTFZU2JGZTZ6V3gvTzh6cndpNENtajRiN0pSbVdscmdRNDNQZFVhbmowL1l5?=
 =?utf-8?B?MFdVNkJOdWJSY1JxeWpwRzBoejlPQ0VnYU0zdzVVUUJvUEZsYWxXVWxKeEJj?=
 =?utf-8?B?R3hVQmZ6Q1NGbDFjVFhNM3JBRFpxbkRySnJhZVdZaHNWK05ldTJ0TEUyOGx6?=
 =?utf-8?B?dUQxb2Qya1d0Yzl6dURIL2o0UnZzQ1BUYnY4dHVxaGZJWDZaYTNEWENuZEZ4?=
 =?utf-8?B?QjZONk4yaHVBN0lNcXh5MSt3QXF2czZPNDVPRnNzWi9JWnE1S05FQ216Y05U?=
 =?utf-8?B?cW9YTFhKNGZVM2pGbzdRcDd3UkJSdjRGa3ptcVVNdS8yM3V5MVQzbS9JUUVY?=
 =?utf-8?B?RlF0d1FpVnoyQkFpTFhmMi81K1k3T0xMT3hWNFNicjd0alVpeWhUaUY5WG1H?=
 =?utf-8?B?eGNTWkVmK2JVcTFaa1pTOFY5VHhaZ2dNWWFvN3d0MjdETEVmekxwNTI0RDZa?=
 =?utf-8?B?K1NpVTVLK2xlL3BQV2EvZ3dQZzZOR3FWWjlDT3Y4QjVhRjlxd2cyMXhzakda?=
 =?utf-8?B?aDNpMnNQWGw2M2wrTGRqUjV6OFFhQnRQazZzWjZUTVZFR0U4TGZ6U3lNTHZp?=
 =?utf-8?B?R3hVZGJueXlid3p4QURicmhheEVGcnE2ZHNNdWdkdkZPeUdkRjh5N3RZdTd0?=
 =?utf-8?B?Y0VMZkZaNWZMdSswc0hITGJOT1lOWkt2VnJQVGwvb3R6OERRWERiN2gxRElZ?=
 =?utf-8?B?RXl3dmZEMjNqY2tIME54L09LY0o0WTRWR2dobFA4VlFRb2VmMmZmVkFnQ3Jm?=
 =?utf-8?B?QlBTN1ZaMGp6eTFpZ0ZlUzJ1dFlnVnBVOVRxS1FVa3pac1dHRTlxLzFZQ1lH?=
 =?utf-8?B?blNKQ0Mzc1Jib1hlZUEvS0RwWnRMRGJJSHZOdFREQ3FpOUU2YlgyL3VXcGRS?=
 =?utf-8?B?VlUzTS9tVmVCWVY2ZTlINjQvQmluZVFyQ2E4S09QcnkxR3pPNk1veTlqaVZr?=
 =?utf-8?B?dTgyYzVEK3dKNnVNakZmN0Yzb1VMRkZvbVJzU2RSWFNRSnF2ODJiZzEvMDN3?=
 =?utf-8?B?cXhkelZCRzZjNnphZWxvb3Z1c3JRajBDRFN0WHhkUC9PVzdXUk8yNlVER05t?=
 =?utf-8?B?TW15dE80dXgzbmQ3bGdYM1lIcG5BcnVGcTZENHQzSTNnNXBnTDRDeGRvTVNW?=
 =?utf-8?B?WVFId2hNYlV1ZE14UG92V05mbXVHR3NCUnU1cG9UaEN0ZnB3NVpLeWxySmVq?=
 =?utf-8?B?bjBZRUZTNE5iSDFwNFMvMDhCbjFLdHFVcVcya1UrN0pzLzh0NmhqTk1HaXlO?=
 =?utf-8?B?ZWlqRlhrNUVpb1hHS1lPZDA0cWNZN1RUa2ZGZ1U1UlREUmpFYU1uSG82UllH?=
 =?utf-8?Q?po1oJ5g2HvQe4wIUqVDQoPu574qOnwexQIqbM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?R2daWnZHcDBKeEZhTGtiUDY0NGtPMjJyQkV4YXVwclNnUmdGYTFOcmVlM1c2?=
 =?utf-8?B?R0xSMGlxazVKMGZDUHN6cUl0V1VBQ2crWEJ4ck1UMnpQQnlyZzVlOUZ2RUhl?=
 =?utf-8?B?RnRuMzVwVzNHNmlOczlsQTdWb1ZIOEdSR0gwRDBaQzE1VEYvRC9VbTJEbmY1?=
 =?utf-8?B?a1pvQUEwVVJYbmJYMURMUG5tOU01czhvU0pRMHNhcmM5VjA1R2dlMDVoMksz?=
 =?utf-8?B?V1ZJT3BtZzQwek04aEsrT1NGdExWdXlFcGNncTJIdU5SYUM2TXhtc2lQaUtz?=
 =?utf-8?B?SlNQU1JZMTRqNXdtdmlJSnpWdmRlQlJUUjZkMTg3NExsbE5HajdRVVdGakU5?=
 =?utf-8?B?UDdxY2ozTGNFY2luY28zS3lpMEJTY29TbHA0VGkrUTdEc0JGbVJRODcxRlVa?=
 =?utf-8?B?NTRyMzdZMEw4UEVYSjVHMEQwRi9KZDVTVHRXek04MXhCVHdlVmk1T2xDQmRh?=
 =?utf-8?B?SXpDVFZLRVBvS0dCdzdVUW9sNXJGbGppYmdPQUhoQSt1dzRvT25PUGtOOGg0?=
 =?utf-8?B?UTlDVnF4a3U1cFBvSUxBbUtCdVZUUWZUNENYK2VLelZNSXJmWEQ5RHBRaDdh?=
 =?utf-8?B?ZGI5L0wrSkhKeW1SeHBHVENuZzYrUFRjME45VFM4cVJKeHVEcHo5aytZWU0y?=
 =?utf-8?B?VGU2MFd0WGVMUTVkdlZDZkVWNDhpZnBvdCtKWFNVRnlNN0l0TFVCTTk4K0VL?=
 =?utf-8?B?c2NlVGovTU1zVUZOMzJ5QXVrR0ppaHNuVlFUYnZHYWNZNXROb2pCUFBUMmNq?=
 =?utf-8?B?bGpMUWZCZmtSY0dRTVRaYUQ5RUQyK3VPZDhhclpiQndHR1Q5V2FtTGl0ZXFm?=
 =?utf-8?B?cU1SYmgxU2k0b3hiaHhMaGlndGMxZ0dQWFVYTFZacXJtZDNIZDNYUXpYUytx?=
 =?utf-8?B?VW5oTmdnSVd1ZXBiSHVRV0htZTYwbytLalRwaWh1bU9ubW5kVG9yTFFBaGh6?=
 =?utf-8?B?YjVCeDVPNGI3dXBoM1NFOG9yK2RoZjZNVEpxdHlDdkZOdU9BQ0Z2bSt4aGRt?=
 =?utf-8?B?cEZrUnBrY2wwM3Zqb1NuK0RoR1Z4aVcydHRiYVlWVERoR0RERHhoa2tRWlQ1?=
 =?utf-8?B?OU1pZVNicmlpSzlTSHA2MXpxSDZ3VnFORDE4aS9JRTY5aFBhbW5ZMnNJemZG?=
 =?utf-8?B?QlcrS1FXRVIwVHJadCtaYWxOWjQvUEJMKzkxUzdFTkhVVVphdUtjWjVreHFs?=
 =?utf-8?B?UzV0RG9UWFNSNFhyUkh5dEVLcS8xWUlyZS9Vd20rNHVtMUlIMmx1NVlHbGtY?=
 =?utf-8?B?MGZuOGk4RjZ5RjlpWG56aEZ5U2ltRkFEQ1FqQnpyWXlDbG5MRHlld0YzKzBP?=
 =?utf-8?B?dUtKdGNCQzVzcXh1TEZ5ai9BdW84YXRMVXlRSWdlbWFwMGhIZ09LNFVzQklO?=
 =?utf-8?B?NlVNOExYSkt6YmVxWmp3YTkzRS9SKzFCZDRNbEpFd0lpcGVFR1kwaDJaU3Vo?=
 =?utf-8?B?dWVscGtFNnFQcHgzdXFtYnVqZUNhVTYvTGtyVzZtNUh4dFp4aTVrS3RqZThn?=
 =?utf-8?B?MlZRSE93RW53M3RKbkVHekMxY1BZTzJYQkJSakdkNmU4R0xrRUFZRXJoT0ov?=
 =?utf-8?B?Nm5jOURZSkhFclhsM3o0UkNLYnh3UTNha1hSaEFFRG9SbFpBNHRMdlE3Ukcv?=
 =?utf-8?B?cEZyTmJsUnBrN0duZ29ydGtLTGlxOFlVUVZzVjk3VXJyRWJkYlBDNkJoUmFF?=
 =?utf-8?B?b1ZoRUNtdXRZTzVjUDZneGlEM2l4MC92bmJlYVBwY3J2eCszUFhxUkxDU3dK?=
 =?utf-8?B?eU05YmZKcnlxRm0zT2d6cERLbGVjcG9lNXF0RzRJM01Wd2lBV0RiZmlsUXIv?=
 =?utf-8?B?ZzIyZ2N4eHZmQW5ZanptbVNiYjBkWmRrYjJBUDBIcWwzZ1lpYUMvZ080Y1hU?=
 =?utf-8?B?OWNZYjRtU3VpTHlBakJ2TzEzVzFjc0hsOXZ4OGtnQUZURlFxNXNQVG1GUkZs?=
 =?utf-8?B?UU4rVlNZMVdLRFJOeEpwTHkrc2ZlYk91cHpML1hUdWdzdlFZcDk3cXJYYUVK?=
 =?utf-8?B?MVovcDg0ek9PVU1pZXRqL3VaSzJNb2RzNU00QXZjaWRyWG1IamJLdXBvZkxw?=
 =?utf-8?B?SlBZVDh2WjV1VkF5TlovUWtFRGViQjFFSzRqN0FpVXJBRkUySmRWM21rZjl1?=
 =?utf-8?B?bmdlWHdybXpsRGgrOEp3WXlIZVorL0ZCSUtmMDdEUnlWWVVoQ2xMU0MrckdE?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5184d087-0bf9-4242-52b7-08dcac725b3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 06:23:53.6363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qeg19vc6ZVLsHQhOAkwqLVryxImFOVxXKA0JdiHZUuh67vpG8l0ufi2OWeooTdRjnGfGEaDAyzLT+Tvujk8ZCmb5UKJ/ZWIxXUQWqW5PGketrPMBd+Fo4ZgChyWOQe+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9472
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jul 2024 06:24:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16617

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdWwgQmFy
a2VyIDxwYXVsLmJhcmtlci5jdEBicC5yZW5lc2FzLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBK
dWx5IDI0LCAyMDI0IDU6MDEgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3Jn
OyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKXi++8pO+8qe+8tO+8o+KWoQ0KPiDv
vKTvvKnvvLTil4vvvK/vvLPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47
IFBhdmVsIE1hY2hlaw0KPiA8cGF2ZWxAZGVueC5kZT4NCj4gQ2M6IEJpanUgRGFzIDxiaWp1LmRh
cy5qekBicC5yZW5lc2FzLmNvbT47IExhZCBQcmFiaGFrYXINCj4gPHByYWJoYWthci5tYWhhZGV2
LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDYuMS55LWNpcCAwMC8x
MV0gQmFja3BvcnQgcmF2YiBkcml2ZXIgaW1wcm92ZW1lbnRzDQo+IA0KPiBUaGlzIHNlcmllcyBp
bmNsdWRlcyBhbGwgcmVsZXZhbnQgZml4ZXMsIHRpZHktdXBzIGFuZCBvdGhlciBpbXByb3ZlbWVu
dHMgdG8gdGhlDQo+IHJhdmIgZHJpdmVyIHByZXNlbnQgaW4gTGludXggdjYuMTAuIEJhY2twb3J0
aW5nIHRoZXNlIHBhdGNoZXMgaXMgYSBwcmVyZXF1aXNpdGUNCj4gc28gdGhhdCB3ZSBjYW4gYmFj
a3BvcnQgdGhlIEdiRXRoIHBlcmZvcm1hbmNlIGltcHJvdmVtZW50IHBhdGNoZXMgd2hpY2gNCj4g
d2lsbCBiZSBpbmNsdWRlZCBpbiBMaW51eCB2Ni4xMSBbMV0uDQo+IA0KPiBbMV06DQo+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDYwNDA3MjgyNS43NDkwLTEtcGF1bC5iYXJrZXIu
Y3RAYnAucmVuZXNhDQo+IHMuY29tLw0KPiANCj4gTmlrbGFzIFPDtmRlcmx1bmQgKDcpOg0KPiAg
IHJhdmI6IEdyb3VwIGRlc2NyaXB0b3IgdHlwZXMgdXNlZCBpbiBSeCByaW5nDQo+ICAgcmF2Yjog
TWFrZSBpdCBjbGVhciB0aGUgaW5mb3JtYXRpb24gcmVsYXRlcyB0byBtYXhpbXVtIGZyYW1lIHNp
emUNCj4gICByYXZiOiBDcmVhdGUgaGVscGVyIHRvIGFsbG9jYXRlIHNrYiBhbmQgYWxpZ24gaXQN
Cj4gICByYXZiOiBVc2UgdGhlIG1heCBmcmFtZSBzaXplIGZyb20gaGFyZHdhcmUgaW5mbyBmb3Ig
UlovRzJMDQo+ICAgcmF2YjogTW92ZSBtYXhpbXVtIFJ4IGRlc2NyaXB0b3IgZGF0YSB1c2FnZSB0
byBpbmZvIHN0cnVjdA0KPiAgIHJhdmI6IFVuaWZ5IFJ4IHJpbmcgbWFpbnRlbmFuY2UgY29kZSBw
YXRocw0KPiAgIHJhdmI6IENvcnJlY3QgYnVmZmVyIHNpemUgdG8gbWFwIGZvciBSLUNhciBSeA0K
PiANCj4gUGF1bCBCYXJrZXIgKDQpOg0KPiAgIG5ldDogcmF2YjogQ291bnQgcGFja2V0cyBpbnN0
ZWFkIG9mIGRlc2NyaXB0b3JzIGluIEdiRXRoIFJYIHBhdGgNCj4gICBnZXQ6IHJhdmI6IENvdW50
IHBhY2tldHMgaW5zdGVhZCBvZiBkZXNjcmlwdG9ycyBpbiBSLUNhciBSWCBwYXRoDQo+ICAgbmV0
OiByYXZiOiBBbGxvdyBSWCBsb29wIHRvIG1vdmUgcGFzdCBETUEgbWFwcGluZyBlcnJvcnMNCj4g
ICBuZXQ6IHJhdmI6IEZpeCBSWCBieXRlIGFjY291bnRpbmcgZm9yIGp1bWJvIHBhY2tldHMNCj4g
DQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9yZW5lc2FzL3JhdmIuaCAgICAgIHwgIDIwICstDQo+
ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9yZW5lc2FzL3JhdmJfbWFpbi5jIHwgMjkwDQo+ICsrKysr
KysrKy0tLS0tLS0tLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDExOSBpbnNlcnRpb25zKCsp
LCAxOTEgZGVsZXRpb25zKC0pDQoNCkkgcmV2aWV3ZWQgdGhpcyBzZXJpZXMsIHRoZXJlIGFyZSBu
byBwcm9ibGVtcy4NCkkgY2FuIGFwcGx5IHRoaXMgc2VyaWVzLCBpZiB0aGVyZSBhcmUgbm8gb3Ro
ZXIgY29tbWVudHMuDQoNClJldmlld2VkLWJ5OiBOb2J1aGlybyBJd2FtYXRzdSA8bm9idWhpcm8x
Lml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==


