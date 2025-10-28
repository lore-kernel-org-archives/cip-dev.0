Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5666FCCF9E0
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 07:31:46 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.6190.1761636700186542901
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 00:31:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 59S7Vbm52839282; Tue, 28 Oct 2025 16:31:38 +0900
X-Iguazu-Qid: 2yAbDoX6mPezKvSuRj
X-Iguazu-QSIG: v=2; s=0; t=1761636697; q=2yAbDoX6mPezKvSuRj; m=AkHRnRdzNkeTP4PPjS64UE1M7Ku+AyAih45SseraF/U=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cwhrn2jMxz1xnc; Tue, 28 Oct 2025 16:31:36 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHzawOdYkQxBT4D2WvUoge3NXlknbFS8aI0eZe/do+1MYT3OZslRU+L3jgjvse0+knglPF8odBT3u25fOnEKf+n2GyQ8+7Ls0oPFoz6hwCaKAabqoRAopnlw0Ty4ibvHxw9A4jiwExuAW+AQhupTlbMIV4MGxHatwTIDdUnWSinXaf4cx+LjDfvCvNI5REpfqRacxLY7JKQA1BQo2mNXFZMwmSKQ+HYh+s2N5mpbTpJHFXh0iUDyyIHGmfUhnI0ngnZ6hxKtEkvIhYsNL4mncVGqZun9TOfL8uSZr2jl7i+FXDkrC8pGkALuGqNN7RauZAlV297WbbiktFnmipyFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h75lIJm7uQ+sd+qDHGxcoUVdkZariK3itdGa4owWT88=;
 b=fap2OZhDdi548gFDXIqoCRV2THgt3RBa8tM+lV6acaElcCZJs9/MpI6MowhGz4wIhikqxM+EVnjWEpSqMSjejS+atO9QzUoEDic81WTuxdj1IUoIyj3wYxQC+Yh1SRX/oBMzuVHVSFi82ayuPDPtRsp5BnZUH7yihsixzPXjpepmUdSjcnRq+6jpjJqWooYbQBlY3TiT9DYfuEZvXpxEvMkw0g3nklMikUDSjnmBCgpIaIfnGekhbk2GNpo5jJmD65YHkxxl+rth3HueUDbzycyPhkK83Lcbdh/ufUZHFFkCBrLmE2GPACpsewAayAYSaLabw7FmMlbBcb3nK1M3/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>,
        <akunuri.sahithi@toshiba-tsip.com>
Subject: Re: [cip-dev] [isar-cip-core][RFC v2 0/5] Enable support for wfx
 backend based software updates
Thread-Topic: [cip-dev] [isar-cip-core][RFC v2 0/5] Enable support for wfx
 backend based software updates
Thread-Index: AQHcR8yXUw+OJx5BuUud53aTobS52LTXKX8O
Date: Tue, 28 Oct 2025 07:31:34 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB96690A02857F4B9B3E08E9DBC4FDA@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <187290DC79541D18.436@lists.cip-project.org>
In-Reply-To: <187290DC79541D18.436@lists.cip-project.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OS7PR01MB17195:EE_
x-ms-office365-filtering-correlation-id: 4ac4c0c5-74cd-4784-1d47-08de15f405e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|8096899003|13003099007|38070700021|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?R2RCMkwwL0wxOVl6ZUtQSGJ3eGhFeEdIN3gwMUFEb1RHRDJUb0lYY0lz?=
 =?iso-2022-jp?B?SVZoZjNhME1nTG9XWVdwRVo2dkdpRit1aXVVRi9LTUltTW5NSEM3S0dv?=
 =?iso-2022-jp?B?QUxsQ0M4M0Y3eHR1NTNQZXRJZkk0RnEyem5Hejc4b2ZmK0hJWkJuU3gz?=
 =?iso-2022-jp?B?eTJxVVNBNHo2QU12SlJ4UXdCR05qemJSbnB4R3F5L2J5T2VGUFp0dHBL?=
 =?iso-2022-jp?B?ckJMaUo1N2t1aFo2dHBSOTlTV2poamJ0Y1kzSXhDdHk2SytvVUVOektr?=
 =?iso-2022-jp?B?NUUwVFhmT1ZSTlVpNDBUS2RLWUdvQ2VaU0M4ei9POGl3NEtmUEFXUDVv?=
 =?iso-2022-jp?B?aW9xRkhOR25Mc3hQY1FXSUNUVHB2Wll1bkVsQk9LUmZmOE83eGpIRTBp?=
 =?iso-2022-jp?B?NzdVRkJwL2FaK05kV1pBYUZxTk96TEFwYytlZUl3bW41dnJFWGVjNFVp?=
 =?iso-2022-jp?B?RjJ5WUpFN2ZvYUhTMEpoMy8zSHQ4ampTRHFJWEl1ZHRUa1cyZkpaejRF?=
 =?iso-2022-jp?B?cTJyNUd1eFdqamRKWXl2VnAyRDdhdFphSzk2SGtzL09iOEFnajMycjIy?=
 =?iso-2022-jp?B?RjQxdkQ4L1MvZmU5Q2RnL3ROTEVpS3FnNGJqNkRQbDRSamV3SXdLU3Fs?=
 =?iso-2022-jp?B?UjJPQUs5MmNnaFBvTXFlVGZzNmxlNlpKTmcxQlZZak5lb3A2Ynloa0FR?=
 =?iso-2022-jp?B?VlB4U2RySUdLNmtvQTdJb0pGcTFMSkU3ZzlEZVVkSU5hZjdOMG1sL1Q1?=
 =?iso-2022-jp?B?eDd0TndrMXhlNTg4OVBwMGxSdnJiYW1mdG0vRU5YeDB3VWxaVEt0TEVG?=
 =?iso-2022-jp?B?aWFoRk4rWU9DaTZodXI5c3pHSW5KcFAxV01hOTd3eGV0NHF2Q2xIaFNU?=
 =?iso-2022-jp?B?TTVwRDg4Ujcwcjd2WUlFN0Q4d1o2UVoybVZQcHMvVkwvZVR6a1p3M3hG?=
 =?iso-2022-jp?B?bHNwcCtkSzlGUVYvMzRwVFZsa3dzWVlaODFpSVV0M05ucU9PQmlycWUy?=
 =?iso-2022-jp?B?U1Z3aWZVVUt6TE11bEpybGNTdnlReVdDR0JBU0srR0dNZ1pzbVEyTFR1?=
 =?iso-2022-jp?B?U3pvWkFiNG9acGthSXRqeDVCaFdtSE5KRVdXMzF4dk1ZeU8zUlhPU053?=
 =?iso-2022-jp?B?MjMvamg2eU82b2gzblYxTFpOY0RjU3ViQUlvMjNMZzdiUmwzUGlyb2Jo?=
 =?iso-2022-jp?B?UW1HNkxsTEZNbEExUUc0cTZzVTRqTHVwVjE5TjFWMWIxRUhrR0xrVWJ4?=
 =?iso-2022-jp?B?a2ZVZ2cyNXV3WTM0eS9aV1dYL3FZb3l6RmVkcGRaQ1cwa0Y2Z0krb01I?=
 =?iso-2022-jp?B?a3liWUxHd2VOR2Q0eUlidXo2SFk4dWVOSFk4L2J0ZmJnSzBZeGFMWnV3?=
 =?iso-2022-jp?B?ZVRWdENDaEdTUC9TNWQwU0pLTnRwdloveW5GVXU2VkdyU3IxU1RGOUJl?=
 =?iso-2022-jp?B?bmtOc01Qa3lkbDU3TjI3aUxNb3lqdFBXNlA0MDlRTTV6cXJRNjhjbDVu?=
 =?iso-2022-jp?B?SmRpZHpiMHZpN2t5U2dmS053QlRmbG1yL0JNZTYxbWNMK2tkcnlrMS9N?=
 =?iso-2022-jp?B?LzBkeGwzTkNaMnpqaFNaQmhXQXE5WGt1bVFxWEdoSXNqcHJqQm5MenRQ?=
 =?iso-2022-jp?B?WWVPWnAvK0RRR0tiSmM5bnVsS2I1V1hVNjkwNkxTbjB5bmFDNXVQRUt1?=
 =?iso-2022-jp?B?ekxJRDBYV0REMnBpNWYwMGdmeTMrWXVqK2Q2K0Ztbm4yY0k1VzVhTVJJ?=
 =?iso-2022-jp?B?VC9FOTBINmVnMzBtemJrWTdTTzJLY0RRVTFua2phcWlQajZseWM1U044?=
 =?iso-2022-jp?B?OWhQN0pMS0Rsd2IweVF3QWR5ZmhqSEROR2xySC9uREp0NzN4Umw4V09s?=
 =?iso-2022-jp?B?NmJtdHFTdDNVTW1qeWFKb25PVlE3WkZLRm5pQ3BLeGpveEFRSXdIdUY4?=
 =?iso-2022-jp?B?MjlpTEI3VDZ0alNoR1lTdHVISTYzZlZMM0FXUDVDSzBZa1pvcDlHNkUx?=
 =?iso-2022-jp?B?cmJpR3pCTUhwUFpBUkdxTjJodkVTMUZSK3FNV0xsMWlFeVR6VjJmQngr?=
 =?iso-2022-jp?B?eHgxSkpWSHVLOTA3clBTSnNzdmxrTEZ4MjUwdzg1VjM3MUNFdGVkczlL?=
 =?iso-2022-jp?B?eUZNSmNveGNPYnF3eXdoVUM2M2JYSHJ5di9ZRGNSNGdXZkcvelpmL2Iw?=
 =?iso-2022-jp?B?UHRFPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(8096899003)(13003099007)(38070700021)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MEZHVWxyYkpoZWpsUGphV0xkRnZ5dWxrY0gxSzRCYkJNM29wUDM4MHEx?=
 =?iso-2022-jp?B?ZlVXei9hc0IvQjBWNXNiMHZ0R2JYbi9GMjJ0OUFOSlB3T2prQjBhQ1Bt?=
 =?iso-2022-jp?B?T3dFalVrdEtwK1E1N0FTS0VBeEJZTzdmTnpxWHBJNWVDOG5YSzZBRS9Q?=
 =?iso-2022-jp?B?Y29SdXQ4NmlQdVJGcW1WeUZwWFU4eGNLWmlCVXhWMmZXRHF6L0JnaDRG?=
 =?iso-2022-jp?B?aGo5VWFIOExiTVQ4L2tINzdldWVOR29MYkhJcW4rZmxBcVloaEo2alVw?=
 =?iso-2022-jp?B?aVJjTkFrZkRHbkpQWGJzODJ3UnNKOU40cTRWOHMraktmUTBSbXd2elhi?=
 =?iso-2022-jp?B?bTlWRVdjMmVMcHZoYW5jOUpKaGtDT215MmJCQnR6bWxjQW9aZEdDa3NF?=
 =?iso-2022-jp?B?WjJNUDNJMThFNHBDbDFSQmJmMkM5b1pBSG5rVTd6UkZreGMyYlBmWUZO?=
 =?iso-2022-jp?B?RU9xWkdlZHQ0THFtUFB3VkJHSEgvQklUcXdKY1NaOEVaaUFicTNSZkNx?=
 =?iso-2022-jp?B?TmNKVm9zV2orSGJRUEkyb2dsSVppNDN0SVJzNkplUk1xL0NWbEZPcDVZ?=
 =?iso-2022-jp?B?RlE1TkN1UFRLSVZUeitEMDRRZFllU3VoSFBFRTlRb1J2dmkwRXZhVmtY?=
 =?iso-2022-jp?B?MEZiU1pqNUJmSnM0NkswdWV0QmlYSTZXZ0Mwb1U5a3hXS25uWGZSS0s3?=
 =?iso-2022-jp?B?V1E4aWs3M1cxZTQxRjcwdkxlRHhHb0d3NlhsTk5JZVRmYU13RjJSZVJ3?=
 =?iso-2022-jp?B?cE85S3RFbFA4TC9ibEVLRVlQY1poM2pCS09aTUpIOWNYSHVEWmhyaDZr?=
 =?iso-2022-jp?B?dVoxbnY1Nnh2TnFmVUQ0NnJrSlc2aVZSMFA5dW1qQVJVdFJadCtsN0Zm?=
 =?iso-2022-jp?B?eGUvRForKzhTOHZCTWNVa0x4bVEzY1F4OUNDS2Z4UkFLMVVaV1Ywdksv?=
 =?iso-2022-jp?B?eHR3dE8vL2ZXMjJyR2JlSGpvaFRsSUJ0ckhqMERIMTdiUkRuYWdoSW5j?=
 =?iso-2022-jp?B?NTg0bGR1T3FWdDhhTHFiQlcrUjM1ZDQxSk1DeXdlUDI4cjVqWEd4dU14?=
 =?iso-2022-jp?B?a0o1dG1wdEcxc1NLTWM5Z0gvQUNEeU56S09neFZqd0RhWDJIcFFEb2Fj?=
 =?iso-2022-jp?B?SWdEcU9qN2I5ZVliN2o4R1FaUFF5RDJrcmNCODVwUHlDQVpkbzlZQ0Uz?=
 =?iso-2022-jp?B?R0lpY0VPbDd1eUhxd2FZMmxqaVZnZjB1a0R5QkdjbUxwS1FQZGxCYVBT?=
 =?iso-2022-jp?B?OXBUQVhKQWl6bGxPdDNxM0dpY3J4b0VIUTVwSzIxWU9EaFJOMGVuUHpl?=
 =?iso-2022-jp?B?Y1o5VFpCeFRCekd3RWNyeEVwSVJaallCZUl5TnpXQktEblFtK3hvSExQ?=
 =?iso-2022-jp?B?UDZzYlVOaVNSSnMwTm5ndTVEK294TU9tRW9FRWxUWUk4WHIzOTUwNmRW?=
 =?iso-2022-jp?B?ejhVMHZmM0tpcWNQSG1GNjJSZXZzbTBoRTB3cjJCNHh4STZ6WE5XbkRB?=
 =?iso-2022-jp?B?aFBFVXFqTHlvdFpkU2RFcjFkNjdZQTJCaHRHSWY4aEpxZloweHcxYUtB?=
 =?iso-2022-jp?B?QTFySmVabVl3dTNLS1dSbDFldUJWRW4va0xEVEthYmxhZ0tFRUtrQWZ0?=
 =?iso-2022-jp?B?d3BqZkN4VnUrdXhlMHJIUUc0TXF1ajVlckdkbWpJbVRKazByTlNpaTd5?=
 =?iso-2022-jp?B?TFM3aXo3RXEvVy9wK0MvUEdZUU0rWkI1MFZFMlIyQkRRblFOOVZ0NWsv?=
 =?iso-2022-jp?B?VU9Mb21kcTZYM3Y0ZWhpV1pSaVF3eHVyVXJDZWg4Y0huRnlmcDZBSWoz?=
 =?iso-2022-jp?B?dSt1YllkNERRYU0zTE5IS1gzSmgzd3pKY0N4MDJhaytLOFp4N2Fzenhs?=
 =?iso-2022-jp?B?aVExYzQrVEZOYzJPTDhNVWRScXZKWFk1a1BJZ1RGZUtqV2lpd09COXQv?=
 =?iso-2022-jp?B?RFVTbEYzV1N2NGp6S3lMZ3Bla05wdS9SRjZnKzJSNHowSlBjR0ZSRW5h?=
 =?iso-2022-jp?B?NWMrT0J4NWh4M2VPU0E3QlRiU3FsenpCV1NCMHplNDFQRUVXWU4rTGZt?=
 =?iso-2022-jp?B?Q3kzektXUnA5aTBrTkhnaWxQL1RON2tWaEFmYkNKUHZRNXc4WEJUOExV?=
 =?iso-2022-jp?B?YWJ5LzNKeSt0WWE4OHdQNmU1amdpNWJXM0szZE5SY2hZZGJQdXM0VjBK?=
 =?iso-2022-jp?B?RFV4YlFOakJ5NHFKT0xkTlF1ZytxZmswMlplNjUvQmZleDU5VzFwc0FU?=
 =?iso-2022-jp?B?K29UY2k4dUhKSFZKR1NsakdtMFVyL2RmT2NGWDBUVUZ0ZzBPOVR3K3pC?=
 =?iso-2022-jp?B?Mi95MllqclY5NWRNVkU2Y21pSnREZkpmdHc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB96690A02857F4B9B3E08E9DBC4FDATYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac4c0c5-74cd-4784-1d47-08de15f405e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 07:31:34.7570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iB2EdFZ6FQqv7j65OL04SLT04cJF++U8d3ZQLuFMD3xYWk+Jd6Njgk8gazZnpbwUFGTz/tLN5AGb14mgKh5GnYcDULJBlUVNxSXoipLN89IPWE9vIFa4bExwxebC9AVh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17195
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 07:31:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20248

--_000_TYCPR01MB96690A02857F4B9B3E08E9DBC4FDATYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi All,

Please ignore this v2 series. Just found an issue with patch 2 (recipes-cor=
e/swupdate-config: Add suricatta section in swupdate.cfg).
Will share v3 in sometime.

Regards,
Adithya Balakumar
________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
Sent: Tuesday, October 28, 2025 11:04 AM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>; jan.kisz=
ka@siemens.com <jan.kiszka@siemens.com>
Cc: balakumar adithya(=1B$B#T#S#I#P=1B(B =1B$B#D#I#T#C!2#D#I#T=1B(B-=1B$B#O=
#S#T=1B(B) <Adithya.Balakumar@toshiba-tsip.com>; kunijadar shivanand(=1B$B#=
T#S#I#P=1B(B DITC_DIT-OST) <Shivanand.Kunijadar@toshiba-tsip.com>; dinesh k=
umar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>; haya=
shi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <kaz=
uhiro.hayashi.f74@mail.toshiba>; sahithi akunuri(=1B$B#T#S#I#P=1B(B TEUR) <=
akunuri.sahithi@toshiba-tsip.com>
Subject: [cip-dev] [isar-cip-core][RFC v2 0/5] Enable support for wfx backe=
nd based software updates

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

SWUpdate has supported software updates with wfx[1] backend for a while now=
. But using this requires a few configurations in the image (swupdate.cfg).=
 These series of patches enables/sets the necessary configurations required=
 to use wfx for software updates.

For now, I'm sending this as an RFC to understand the opinions of a broader=
 audience.

A couple notes about the implementation:
- Provides using wfx as the update backend as an option (not forced).
- Adds a new section for suricatta in the swupdate.cfg file.
- Starts SWUpdate in suricatta daemon mode at service startup (if wfx suppo=
rt is enabled at build).
- wfx requires a clientId per device in order to target devices (create job=
s for devices). This is currently achieved with wfx-customizations package =
which deploys a script in the image that sets the ID in the swupdate.cfg at=
 run time.
- The above point could be made more practical with something like an onboa=
rding function (See [2], This is still not officially part of the CIP proje=
ct yet).
- Introduces wfx.yml to set wfx specific variables.

[1] https://sbabic.github.io/swupdate/suricatta.html#support-for-wfx
[2] https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin

Changes since v1:
- Rebase to current next
- Drop carrying the patch to fix swupdate issue as its backported to
  debian
- Fix appending suricatta section in swupdate.cfg only if wfx is
  requested at build time
- Use /etc/machine-id as is for client-id in suricatta

Adithya Balakumar (5):
  SWUpdate: Use self-built SWUpdate 2025.05+dfsg-3 for trixie
  recipes-core/swupdate-config: Add suricatta section in swupdate.cfg
  wfx-customizations: Recipe to add wfx helper specific scripts into
    target
  kas/opt/wfx.yml: Set wfx specific variables
  doc/README.swupdate.md: Add section for software update with wfx

 conf/distro/cip-core-trixie.conf              |   1 +
 doc/README.swupdate.md                        | 124 ++++++++++++++++++
 kas/opt/wfx.yml                               |  20 +++
 recipes-core/images/swupdate.inc              |   3 +-
 recipes-core/swupdate-config/files/suricatta  |   1 +
 .../files/{swupdate.cfg =3D> swupdate.cfg.tmpl} |   2 +
 .../swupdate-config/swupdate-config_0.2.bb    |  27 +++-
 .../swupdate/swupdate_2025.05+dfsg-3.bb       |  36 +++++
 .../wfx-customizations/files/override.conf    |   6 +
 .../files/wfx-generate-client-id.sh           |   9 ++
 .../wfx-customizations_0.1.bb                 |  28 ++++
 11 files changed, 254 insertions(+), 3 deletions(-)
 create mode 100644 kas/opt/wfx.yml
 create mode 100644 recipes-core/swupdate-config/files/suricatta
 rename recipes-core/swupdate-config/files/{swupdate.cfg =3D> swupdate.cfg.=
tmpl} (83%)
 create mode 100644 recipes-core/swupdate/swupdate_2025.05+dfsg-3.bb
 create mode 100644 recipes-core/wfx-customizations/files/override.conf
 create mode 100644 recipes-core/wfx-customizations/files/wfx-generate-clie=
nt-id.sh
 create mode 100644 recipes-core/wfx-customizations/wfx-customizations_0.1.=
bb

--
2.39.5



--_000_TYCPR01MB96690A02857F4B9B3E08E9DBC4FDATYCPR01MB9669jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi All,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
Please ignore this v2 series. Just found an issue with patch 2 (recipes-cor=
e/swupdate-config: Add suricatta section in swupdate.cfg).</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Will share v3 in sometime.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Regards,<br>
Adithya Balakumar</div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"></span></div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-proje=
ct.org&gt; on behalf of Adithya Balakumar &lt;Adithya.Balakumar@toshiba-tsi=
p.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, October 28, 2025 11:04 AM<br>
<b>To:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project=
.org&gt;; jan.kiszka@siemens.com &lt;jan.kiszka@siemens.com&gt;<br>
<b>Cc:</b>&nbsp;balakumar adithya(=1B$B#T#S#I#P=1B(B =1B$B#D#I#T#C!2#D#I#T=
=1B(B-=1B$B#O#S#T=1B(B) &lt;Adithya.Balakumar@toshiba-tsip.com&gt;; kunijad=
ar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;Shivanand.Kunijadar@toshi=
ba-tsip.com&gt;; dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;dinesh.k=
umar@toshiba-tsip.com&gt;; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B=
$B""#D#I#T#C!{#C#P#T=1B(B)
 &lt;kazuhiro.hayashi.f74@mail.toshiba&gt;; sahithi akunuri(=1B$B#T#S#I#P=
=1B(B TEUR) &lt;akunuri.sahithi@toshiba-tsip.com&gt;<br>
<b>Subject:</b>&nbsp;[cip-dev] [isar-cip-core][RFC v2 0/5] Enable support f=
or wfx backend based software updates
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">From: Adithya Balakumar &lt;Adithya.Balakum=
ar@toshiba-tsip.com&gt;<br>
<br>
SWUpdate has supported software updates with wfx[1] backend for a while now=
. But using this requires a few configurations in the image (swupdate.cfg).=
 These series of patches enables/sets the necessary configurations required=
 to use wfx for software updates.<br>
<br>
For now, I'm sending this as an RFC to understand the opinions of a broader=
 audience.<br>
<br>
A couple notes about the implementation:<br>
- Provides using wfx as the update backend as an option (not forced).<br>
- Adds a new section for suricatta in the swupdate.cfg file.<br>
- Starts SWUpdate in suricatta daemon mode at service startup (if wfx suppo=
rt is enabled at build).<br>
- wfx requires a clientId per device in order to target devices (create job=
s for devices). This is currently achieved with wfx-customizations package =
which deploys a script in the image that sets the ID in the swupdate.cfg at=
 run time.<br>
- The above point could be made more practical with something like an onboa=
rding function (See [2], This is still not officially part of the CIP proje=
ct yet).<br>
- Introduces wfx.yml to set wfx specific variables.<br>
<br>
[1] <a data-auth=3D"NotApplicable" class=3D"OWAAutoLink" id=3D"OWAc79b5f64-=
6ed6-ee0d-8d8f-79e814636238" href=3D"https://sbabic.github.io/swupdate/suri=
catta.html#support-for-wfx">
https://sbabic.github.io/swupdate/suricatta.html#support-for-wfx</a><br>
[2] <a data-auth=3D"NotApplicable" class=3D"OWAAutoLink" id=3D"OWA57eeef83-=
15f9-a8f6-1c54-d61367062c38" href=3D"https://gitlab.com/cip-playground/cip-=
wfx-onboarding-client-plugin">
https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin</a><br>
<br>
Changes since v1:<br>
- Rebase to current next<br>
- Drop carrying the patch to fix swupdate issue as its backported to<br>
&nbsp; debian<br>
- Fix appending suricatta section in swupdate.cfg only if wfx is<br>
&nbsp; requested at build time<br>
- Use /etc/machine-id as is for client-id in suricatta<br>
<br>
Adithya Balakumar (5):<br>
&nbsp; SWUpdate: Use self-built SWUpdate 2025.05+dfsg-3 for trixie<br>
&nbsp; recipes-core/swupdate-config: Add suricatta section in swupdate.cfg<=
br>
&nbsp; wfx-customizations: Recipe to add wfx helper specific scripts into<b=
r>
&nbsp;&nbsp;&nbsp; target<br>
&nbsp; kas/opt/wfx.yml: Set wfx specific variables<br>
&nbsp; doc/README.swupdate.md: Add section for software update with wfx<br>
<br>
&nbsp;conf/distro/cip-core-trixie.conf&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;doc/README.swupdate.md&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 124 ++++++++++++++++++<br>
&nbsp;kas/opt/wfx.yml&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 20 +++<br>
&nbsp;recipes-core/images/swupdate.inc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;recipes-core/swupdate-config/files/suricatta&nbsp; |&nbsp;&nbsp; 1 +<=
br>
&nbsp;.../files/{swupdate.cfg =3D&gt; swupdate.cfg.tmpl} |&nbsp;&nbsp; 2 +<=
br>
&nbsp;.../swupdate-config/swupdate-config_0.2.bb&nbsp;&nbsp;&nbsp; |&nbsp; =
27 +++-<br>
&nbsp;.../swupdate/swupdate_2025.05+dfsg-3.bb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 36 +++++<br>
&nbsp;.../wfx-customizations/files/override.conf&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 6 +<br>
&nbsp;.../files/wfx-generate-client-id.sh&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 9 ++<br>
&nbsp;.../wfx-customizations_0.1.bb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 28 ++++<br=
>
&nbsp;11 files changed, 254 insertions(+), 3 deletions(-)<br>
&nbsp;create mode 100644 kas/opt/wfx.yml<br>
&nbsp;create mode 100644 recipes-core/swupdate-config/files/suricatta<br>
&nbsp;rename recipes-core/swupdate-config/files/{swupdate.cfg =3D&gt; swupd=
ate.cfg.tmpl} (83%)<br>
&nbsp;create mode 100644 recipes-core/swupdate/swupdate_2025.05+dfsg-3.bb<b=
r>
&nbsp;create mode 100644 recipes-core/wfx-customizations/files/override.con=
f<br>
&nbsp;create mode 100644 recipes-core/wfx-customizations/files/wfx-generate=
-client-id.sh<br>
&nbsp;create mode 100644 recipes-core/wfx-customizations/wfx-customizations=
_0.1.bb<br>
<br>
--<br>
2.39.5<br>
<br>
<br>
</div>
</body>
</html>

--_000_TYCPR01MB96690A02857F4B9B3E08E9DBC4FDATYCPR01MB9669jpnp_--


