Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FD7C369B2
	for <webhook@archiver.kernel.org>; Thu, 17 Apr 2025 14:06:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.9653.1744898816639140549
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Apr 2025 07:06:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 53HE6ndV432625; Thu, 17 Apr 2025 23:06:49 +0900
X-Iguazu-Qid: 2yAbAvUQNAu9UUqJWq
X-Iguazu-QSIG: v=2; s=0; t=1744898809; q=2yAbAvUQNAu9UUqJWq; m=rkjWUixB6vUjD403SLw5D8K7ZKFbFPfbBcglkBC+E+k=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 53HE6m9R3859480
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 23:06:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAo1wMXlKHfq4cevkjAsh5CZE/Rw1KKgzX2GdyeJsCG1BaRPRkP7G/fA0t5ZZp5y3pg5pR0M4r4FrHMWfvELh9lmwhMoUQ21o0sZnwMTPPN1bM7tcHJDsyEkUtFx37sSyxZVACgPZ9Nlda/JqpKARdGRiPFGljh202+mkl9iPpHB34180C/T0z0QBEBNm5ANcGr1qsmBzqWSm+Vh3phQqKXuypBN5ELJ7lx8Wktd0EmtndNehdRFmf3ptCdgL+BkiFd/hjodWjd69OCaVBqerVEADHJhNPO/IhsuCUNoNCdgVSnE55QXzQgGi4lzzyJkFH9LCv+54+oaw/VB8N5e/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/S5rXRX0RQTVQB7pFH/bvmcI38XBqQ8ZnHJriBPYvI=;
 b=w/gZYFUaiuVf6augWJLuk+EouwD0Fd0cnfq6T9h2i3uzXUrmnNLHQ4Gu7DzAXNvWTiXZ0pxxG1Gps17U6NMd5zf9sMhRKSitibCrFRrF0HxWaMi2lEVJoVTXllfZk2sthvqP9EFS6LgiteJyU1WFqmDRX62zz8N8BKC0f+6JrzC9UmITxMXDEiBJX6WdgU4jlQwVhgjAnKu+279PClgtpg8jS0kBXt00C5ORYzdcZT5YNBQJKkecS8KBJC2vdSqaoxYJwtAtCvqgo/6SiG+8eeB7PNNRB/HIvvdvKNDLf8F1iB0hrRjn2pt4Ccc3wVZ1c0YleygpuOZootOxiDBYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <submit@bugs.debian.org>
CC: <jan.kiszka@siemens.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
Subject: Bug report for aide
Thread-Topic: Bug report for aide
Thread-Index: AQHbr6EqYmQziBZNjE2JD4XjCUcucA==
Date: Thu, 17 Apr 2025 14:06:41 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSCPR01MB148381FFFE1BA2C392B96EE60C2BC2@OSCPR01MB14838.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14838:EE_|TY3PR01MB10205:EE_
x-ms-office365-filtering-correlation-id: 8eb5c7cb-bcf9-4427-89ea-08dd7db91430
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|8096899003;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?M2RzTmpzM0hkKzM5TUN6czhObFRiVW1hTHhNNWlXQmkwK2RXeXc2aFRv?=
 =?iso-2022-jp?B?YXlNYXVMWVkxUHM2MmZ0UnU4dGNNdXZBbTdBWDkxaWlrODh6RUJHVDRY?=
 =?iso-2022-jp?B?TEFYdDhFSG05WjAvVnh0R3MyM09XTE9NMVpJdVpDcjdHa3ZEWXhrbUpm?=
 =?iso-2022-jp?B?aXZ6cXlYcm0yeklEcXRON1ZOeE95OG9ud1QyNDNzU05taVFydTljOFBv?=
 =?iso-2022-jp?B?TFAvbGVYYzZiVWpuT0pXS1dXNkdzNkV2dStVaUpqZkV4U3BjZmJBV2dQ?=
 =?iso-2022-jp?B?UktmYUNyaXRVaml0SVJnWThSOGQwaDV2eXpGRHA3RjM0WVhaUnNzTXFz?=
 =?iso-2022-jp?B?N0VQRDkxc2U3dk5YOFVyamk4c3JLeDdsUFFJZnhwajFFUnQ2T0t2ekpH?=
 =?iso-2022-jp?B?ejhaTVRYNUMzWUtyRGxaN0x2Wk95TkErWjNqYUUyQWw4QnM2dlZQV3Vv?=
 =?iso-2022-jp?B?aFVibGxFK0w1RzZ4WmtMMlNmZnpkVWpxNkg1RzE1NUhIeVZsQjN0UlM3?=
 =?iso-2022-jp?B?VXcvUFdZZXIwdmRCUE9wWkxmdkZPQkJ6bnNFbkpGclNIYjMvd1puendP?=
 =?iso-2022-jp?B?ZWVwaThDamNLMHlYcEdjb0FJY3o2d0N1NndIb3VyQWdTRUMvVzNhQVNw?=
 =?iso-2022-jp?B?VlR6a1NYRHVZdW9mUTZPeXd4cGdPZlJhSWlxOThwWkU3ZkpqeXZMNU53?=
 =?iso-2022-jp?B?dDdTTnlJeEk3b1IrZC90OEdLdk1OL3FYaGVpbGJEdDE2aHI3Rzd0NkxV?=
 =?iso-2022-jp?B?Zy84Rk85YzBibVlPWHpHN0t2RE9QRm9vRUgzZjVJUVZRUEdaVUI3KzB6?=
 =?iso-2022-jp?B?WGtLMWVNaTY1dnd1bXhreEphUHRLSjZOQ3QzTlAzazNJOEF2Uld1TWti?=
 =?iso-2022-jp?B?S2txc1VHOFJ0d2R0S25xQmJ4ZzR4aklVSlpoV0MyMGxLMjJxVDRKcURs?=
 =?iso-2022-jp?B?eWZkV0RUM3Zwa0NsU1MzZXFIaFRLSUlTUG9mQTNaZGhzZlZYcXlOMWxQ?=
 =?iso-2022-jp?B?WVdycGFHWkRzSHR0c3lEV1FnOExtSzBpalFwdzBFSWgrMm4zS1BrUjVz?=
 =?iso-2022-jp?B?dVZ2NC95N01idXB2RzRXNXp1Wm1wUVUyWGVwdm1aL1Y2bHMrWjQwRm9m?=
 =?iso-2022-jp?B?ek9PemR3ejZxWkt6SjM4K1Q1REsvc0s5OWwwUnhkT0oyZEk5b3RpSEhI?=
 =?iso-2022-jp?B?aGhGc1oxZnVySU04QW1XSkFIa2E4d0xTVmJaazRsenpaL0lmRjBadkFP?=
 =?iso-2022-jp?B?bWllUmZmSFNlUjVPZnFlNi9rWUs4bksxaHkvNTBMTW9nZlBtVEFSMjhu?=
 =?iso-2022-jp?B?Mmt5L0lMdnNnSnAzU3VYTDljWGMxT25heDVZSXZGak1obG5uSGF2Q3Bx?=
 =?iso-2022-jp?B?VWFXZUFUZGRUTGdOWWlVWWxEcnpiV0xNcXZUSTVRZTd0Z2pJWmdBUmto?=
 =?iso-2022-jp?B?ZzN0WTZBSnFFT0d2dEM3ZGJPVU0rZlZ0Z3BiZDI1N09vcTREc2dxU09w?=
 =?iso-2022-jp?B?NUVtYlo1cnAwWEVJOTVBcFRFM2JkYTBZU3dEOFpQb29RenhYM2NyTmZ2?=
 =?iso-2022-jp?B?RVh0UnM5b2pSbmpyRFBudi9qeWphbHBPbDd2c2lYQWxaNGRuakttS1RV?=
 =?iso-2022-jp?B?VmtFODdyMjVXZU9QWUwzZUNMdWlnWnM0TlRMMnUway9XajdQYk9QTXhp?=
 =?iso-2022-jp?B?eHpWYjJmK3dORUxLWkdHeVd1OFl6QytRZlJ3U3NaT3R4QVh6UDNuNEVL?=
 =?iso-2022-jp?B?OElwcC81bGVQOE9jbEZLbUp5ZXQwMWh0QVNFdVlFTmdkSnB0UVVBK2ND?=
 =?iso-2022-jp?B?MVpJWHJxdkhNcW1SdHRYU0JuN0lpZC94Rm5nb1RzY3J0NGxzM0dvNFUz?=
 =?iso-2022-jp?B?MzJjYys1MCsrN0pIL05sa3BmRDJDd1hBNjk0M2VENlhVa09kUURuZk5s?=
 =?iso-2022-jp?B?MXk5QW1Yc3l6dUZWNUdBL29IMkE1dWppNUtJaDlEYWRJYm5JUm5uN21S?=
 =?iso-2022-jp?B?eUdIYmxvUFc1QTZ1TEliSjlIN2MrS0VjOXZnVnJxTWtMUzNWU1hxM1B0?=
 =?iso-2022-jp?B?M25NbWtpTnJ6WkRvN1h0YkszMU9SNGxBUDRRRklzV09qWk1OZHkyTk5x?=
 =?iso-2022-jp?B?OGlHS05UN3l0STYyN2xmZXJFdVBUVUlBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14838.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SnYwbkNIUWlPdTBZRjFTdTNWbE9aNjJFelJ5TENBVTR0YVpENkxjQ2Fm?=
 =?iso-2022-jp?B?YXpUbHYybmgxcHNDdjB0U1A3V3ZPUHoxUHB2Y1hSRjE0QnNhSlpyVmt4?=
 =?iso-2022-jp?B?ak5Pck5uU2E0RDdGTitGVVBEVXA4aEJxbU5PakNWYmFlSVJNbis4ZEQ5?=
 =?iso-2022-jp?B?dk9zZ1QxdGdyVEo4VDEwSllIWERraGZBNEgwSTcxRWp1dlpOTU52dmZV?=
 =?iso-2022-jp?B?QnZiYXBPZ0JpTlFIdUFLZEpRbFdjNWJ1MktwZms0OHRSbnRRUDkxRVJU?=
 =?iso-2022-jp?B?enN6dWZuRHcycUJwUWZ5OUQ0bU42WXlUK1c0WDhlUGcyVHQxcUhYdmJJ?=
 =?iso-2022-jp?B?V0JHTmMxSnJ4aHpNR1dCd1g1anhKZTZkUEdKTXE4N0hJWHkrczlyWHU5?=
 =?iso-2022-jp?B?QVk1U28veWhnbWR5em93OGY2S1ZLQXJINld3cGdTd1RZa0lCUzk2NVhm?=
 =?iso-2022-jp?B?djJhTVdsQXBlYlRFNUF3cVQyT0dNVllBTndTTmdDM2NFbVZ0NnRxVVB4?=
 =?iso-2022-jp?B?Kzl1ZjkvQWNZcWxXWmpURnA1S0ZXNmNaT3ZpTzRYcVdwZFpwc2tjNlgr?=
 =?iso-2022-jp?B?TnVqc3p6VlZ1bGV3Y0JNYVRvTUYwUGZTbGlyWDRFc3NHSjg1SVY4d3dG?=
 =?iso-2022-jp?B?cnUzUzRaTi9iZDZZdXdDd0ZIWmZFRjZmL0YyRjI1RzR5dTROWU82SXg3?=
 =?iso-2022-jp?B?SmNoWm5tVkw5UGdYcW5pRkhicC8vTVNVTlhwVStjYzZyRU9Hd0NsSXh5?=
 =?iso-2022-jp?B?bHZ6V1RCL0piaTBOZUNsOERBZXJSVWdSSzIxamVYZGt3TGZjYk1WVmRo?=
 =?iso-2022-jp?B?SW00a2xYclJpNFJtdWlaRlBkTkRLdHNJT2ZWcVRVSG9QQnVEVC9QZTl6?=
 =?iso-2022-jp?B?cnh1RTgvQVJmS1IwUnJJZzZqd0tjRlYyRnBkamN6SkN1TXg2aVY1M1VW?=
 =?iso-2022-jp?B?UUJaTTFaYkNpcUFkNkVwMEtvM24zSjdQendaRmJxaTRhV3hLcWQyMjhk?=
 =?iso-2022-jp?B?azd0TUV0ZWRCUklKcHBtSDYwQlFkN2VkR0tIa3psNHF5dEpUNGZyV2lj?=
 =?iso-2022-jp?B?RVhHNFdwMm4wT2JTWUw4Nld2ZDdhelgxZVN6eWxwQWtoQ2JsTVdFWXFQ?=
 =?iso-2022-jp?B?MDFNUFMrcVA4OGRqZEFBbWhmUjdxdmlNWW1ESThwZFVtY0FPSEc1eWJk?=
 =?iso-2022-jp?B?aDJPY1ZkeDFaUG9EaExxSkFsZnpzSTFUaUF6M0NTYnpZY2JEeTNYZTJ2?=
 =?iso-2022-jp?B?NEdNa01TQXYyS1BaZm55K1AvK05FY1hPMVZ0ZU1WZ001c0JRY1NrQVVQ?=
 =?iso-2022-jp?B?ZDIzSGE2VWtqTzZPRkZ5RmhYdzMxT2Vjemp6bXNDM21BbzJsVVZ3T3pG?=
 =?iso-2022-jp?B?ZHRhOUtpaWQ0Z2szdXVnK3I3VStqOEMvS29CSTR5S3ZGbjRDMjJMSWxj?=
 =?iso-2022-jp?B?RjNNMjdsS3VsWE5IS0J0SEl2M29yOHR3d29DUG8vQm8rVC9vaVJGK254?=
 =?iso-2022-jp?B?UDhkd2cza2M0NFUzREtyOFZMamlhNXdyTEFIcm5peUNGM0dCSVI4TVRG?=
 =?iso-2022-jp?B?SWh2UWE2SE8xT1lONWRCWTY0OTZSTzhVWXlFMHpXbXNZY3BvaWtoTmg4?=
 =?iso-2022-jp?B?RExCUjJCVGpxSE4yVStCcGQ0ZkhkcjY4eTdwVVRlV0ZGSEc0TStGcGl6?=
 =?iso-2022-jp?B?L0srQi9XbFY4QlA2SytoNTkvcWJuazAzckl2eG9NVTBXK25SVTBRT3JF?=
 =?iso-2022-jp?B?WEF0L3RwbWpLTkpWdUxXWG12VVkyWkp6OUlkOWhhTGRqSUdSaHpkRiti?=
 =?iso-2022-jp?B?SjEzZ1hCM2dRdVVPMXFIRDA5bk00TkNLZllSWjdIRnowMUNYaHZyNHUv?=
 =?iso-2022-jp?B?NkE2RzBoR0RZTUE4M3FIY2tGK2VuYmE2VzNjSWhHb0Y3WmxNRFNEK2hj?=
 =?iso-2022-jp?B?eXNFSFBLRkNuTTJHRkxTdThPZFhNRTY1Z3pKemtGWmhzczVRSWE0ODRz?=
 =?iso-2022-jp?B?K1J5alk0L3UxQXJuZGhMUUhMNWd6YmNaeWh2ckxMQWhVZWRtVG45V2M1?=
 =?iso-2022-jp?B?NzdjNk9YYW12dWo5a0pYclRnSGZaSjVKZ2FENnc3NlNsZzBydDM4cURp?=
 =?iso-2022-jp?B?MmVkOXoxV2F5Zlg0N1dQeWM5NDZKWjhhOCtpVnhiaVlUMGdtUURHQk85?=
 =?iso-2022-jp?B?TG9vR2hFbjJKM0E5eDZ5VXBGRzU3Qm1MSS9rT0t5c2s0cTV2NlcvcUUy?=
 =?iso-2022-jp?B?dnUvMmxIdTd0ZVZLMEZFZnk2bW9NSGxEWTVrbE1YZmtSc0ZaSzB3SWta?=
 =?iso-2022-jp?B?UXNaVEZLN1RXT0dkbUZiYllQb2EzTmN6dGc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSCPR01MB148381FFFE1BA2C392B96EE60C2BC2OSCPR01MB14838jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14838.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb5c7cb-bcf9-4427-89ea-08dd7db91430
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 14:06:41.7421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RC7r0LiLPr639JzdX++FJsR6xek+NdwHc+7JU2L6YjM7pp7giKGu5tI8oTJbWDT1/V380RVGMm+p2Vo1FgiPQNSY34MhtvHE62kPRBGramM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10205
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Apr 2025 14:06:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18523

--_000_OSCPR01MB148381FFFE1BA2C392B96EE60C2BC2OSCPR01MB14838jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Subject: aide: Failed to include files added in aide.conf in the aide db wh=
en it is initialized in case the path of files mentioned in aide.conf are w=
.r.t symlink directories
Package: aide
X-Debbugs-Cc: sai.sathujoda@toshiba-tsip.com
Version: 0.18.3-1+deb12u3
Severity: important

Dear Maintainer,

In case of bullseye (17.0.3), when I tried to add a file under a symlink di=
rectory (/lib) which points to (/usr/lib), and initialized aide database,
I noticed that in case of bullseye it took that as an entry, you can see th=
at in number of entries.

root@debian:/lib# aide -c /etc/aide/aide.conf --init
Start timestamp: 2025-04-11 14:55:06 +0530 (AIDE 0.17.3)
AIDE initialized database at /var/lib/aide/aide.db.new

Number of entries:      1

---------------------------------------------------
The attributes of the (uncompressed) database(s):
---------------------------------------------------

/var/lib/aide/aide.db.new
 SHA256    : 8QfM4/Mro0bQhMCUinAVdTqs8vnp2RvR
             gfOdwU81lKg=3D
 SHA512    : 6vEeABuJ9vc6A8ynl1zE0V69+jwPrY5y
             POHmNOVSxNbwWY3YCbRmwXOKyoybLKVE
             pqU8oaHcE4BsvmiLF3MpLQ=3D=3D
 RMD160    : 3Tk77kKRJWeGOvMjXgEuBUaUJfU=3D
 TIGER     : K1w+cRPV6jFCuq3cJ8pSfudnOqu36XbL
 CRC32     : qc830g=3D=3D
 HAVAL     : WVO2hNph/UhVccxnESrSLNzFiABLdUCg
             ZI5clgNjQ5Y=3D
 WHIRLPOOL : hCpWmHis0LPvfmZRVBFAdF09ObwXYCRB
             f2u6cH38Bv8FFPBOSQ+et4wzlI+05ukS
             8mJIYMag6JljAZQ3/UjKzw=3D=3D
 GOST      : 7dxCJCfHe6GOILuDqAnKleB4iIfDSoVX
             3EPP/wQZKWE=3D


End timestamp: 2025-04-11 14:55:06 +0530 (run time: 0m 0s)

And it was able detect changes made to the file (permission change) like be=
low:

Start timestamp: 2025-04-11 14:57:09 +0530 (AIDE 0.17.3)
AIDE found differences between database and filesystem!!

Summary:
  Total number of entries:      1
  Added entries:                0
  Removed entries:              0
  Changed entries:              1

---------------------------------------------------
Changed entries:
---------------------------------------------------

f   p..    . A. . : /lib/sample

---------------------------------------------------
Detailed information about changes:
---------------------------------------------------

File: /lib/sample
 Perm      : -rw-r--r--                       | -rwxrwxrwx
 ACL       : A: user::rw-                     | A: user::rwx
             A: group::r--                    | A: group::rwx
             A: other::r--                    | A: other::rwx


But when it came to bookworm (18.0.3), when I tried to add a file under a s=
ymlink directory (/lib) and initialized aide database. The file itself is n=
ot taken as an entry in the database.

Start timestamp: 2025-04-11 02:10:43 -0700 (AIDE 0.18.3)
AIDE successfully initialized database.
New AIDE database written to /var/lib/aide/aide.db.new
Ignored e2fs attributes: EINV

Number of entries:      0

---------------------------------------------------
The attributes of the (uncompressed) database(s):
---------------------------------------------------

/var/lib/aide/aide.db.new
 MD5       : pl93YpGJN9FrSnoqT0E3dw=3D=3D
 SHA1      : rPt7WKDC/q2REGf6zvHo5TYRXo8=3D
 SHA256    : +Vk/YPBigq7YMPdzEAa2BnhQKpKhcDgO
             ufnUJdXz+ww=3D
 SHA512    : wJrUxFj+aQ98FXzB3CgL0TuYips7zww6
             FMMOvSOoReI5C+y5ESPOlwayxtYdFetu
             ksE3lSPfoZ0XRt0jK6tyUQ=3D=3D
 RMD160    : Q7t7ldGDvKL1dtkWebY7ADg5rF0=3D
 TIGER     : Una57HNtE4LT2CtfSQm3/MJJHc0CcMf3
 CRC32     : Iks/HQ=3D=3D
 CRC32B    : 9KQcKQ=3D=3D
 HAVAL     : Ew+OiFudOadA+OXb0OnlLF2dNM7/W3S/
             GdxH7C3h4lQ=3D
 WHIRLPOOL : 65MSMeuSnYHCLCgWnMe4C1s8EPylzOVw
             ty4A+dG1kRseQRQbmT2RqAOwXgd0HOHs
             ipqJzSjmtcnxf+7Wgkdphg=3D=3D
 GOST      : jcvRfvMgkH6BaQMTYegf8COtLbaMB/6i
             TuLy7JXdZPI=3D

End timestamp: 2025-04-11 02:10:43 -0700 (run time: 0m 0s)

And eventually it was not able to detect the change as well.

Is this behavior introduced in aide from bookworm ?


-- System Information:
Debian Release: 12.10
  APT prefers stable-updates
  APT policy: (500, 'stable-updates'), (500, 'stable-security'), (500, 'sta=
ble')
Architecture: amd64 (x86_64)

Kernel: Linux 6.1.0-32-amd64 (SMP w/8 CPU threads; PREEMPT)
Locale: LANG=3Den_US.UTF-8, LC_CTYPE=3Den_US.UTF-8 (charmap=3DUTF-8), LANGU=
AGE not set
Shell: /bin/sh linked to /usr/bin/dash
Init: systemd (via /run/systemd/system)
LSM: AppArmor: enabled

Versions of packages aide depends on:
ii  libacl1       2.3.1-3
ii  libaudit1     1:3.0.9-1
ii  libc6         2.36-9+deb12u10
ii  libcap2       1:2.66-4
ii  libext2fs2    1.47.0-2
ii  libmhash2     0.9.9.9-9
ii  libpcre2-8-0  10.42-1
ii  libselinux1   3.4-1+b6
ii  zlib1g        1:1.2.13.dfsg-1

Versions of packages aide recommends:
ii  aide-common  0.18.3-1+deb12u3

Versions of packages aide suggests:
pn  figlet  <none>

-- no debconf information

Thanks and regards,
Sai Ashrith


--_000_OSCPR01MB148381FFFE1BA2C392B96EE60C2BC2OSCPR01MB14838jp_
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
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">Sub=
ject: aide: Failed to include files added in aide.conf in the aide db when =
it is initialized in case the path
 of files mentioned in aide.conf are w.r.t symlink directories</span>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Package: aide</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
X-Debbugs-Cc: sai.sathujoda@toshiba-tsip.com</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Version: 0.18.3-1+deb12u3</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Severity: important</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Dear Maintainer,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
In case of bullseye (17.0.3), when I tried to add a file under a symlink di=
rectory (/lib) which points to (/usr/lib), and initialized aide database,</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I noticed that in case of bullseye it took that as an entry, you can see th=
at in number of entries.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
root@debian:/lib# aide -c /etc/aide/aide.conf --init</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Start timestamp: 2025-04-11 14:55:06 +0530 (AIDE 0.17.3)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
AIDE initialized database at /var/lib/aide/aide.db.new</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Number of entries: &nbsp; &nbsp; &nbsp;1</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
---------------------------------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The attributes of the (uncompressed) database(s):</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
---------------------------------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
/var/lib/aide/aide.db.new</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;SHA256 &nbsp; &nbsp;: 8QfM4/Mro0bQhMCUinAVdTqs8vnp2RvR</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;gfOdwU81lKg=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;SHA512 &nbsp; &nbsp;: 6vEeABuJ9vc6A8ynl1zE0V69+jwPrY5y</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;POHmNOVSxNbwWY3YCbRmwXOKyoy=
bLKVE</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pqU8oaHcE4BsvmiLF3MpLQ=3D=
=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;RMD160 &nbsp; &nbsp;: 3Tk77kKRJWeGOvMjXgEuBUaUJfU=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;TIGER &nbsp; &nbsp; : K1w+cRPV6jFCuq3cJ8pSfudnOqu36XbL</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;CRC32 &nbsp; &nbsp; : qc830g=3D=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;HAVAL &nbsp; &nbsp; : WVO2hNph/UhVccxnESrSLNzFiABLdUCg</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ZI5clgNjQ5Y=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;WHIRLPOOL : hCpWmHis0LPvfmZRVBFAdF09ObwXYCRB</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;f2u6cH38Bv8FFPBOSQ+et4wzlI+=
05ukS</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;8mJIYMag6JljAZQ3/UjKzw=3D=
=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;GOST &nbsp; &nbsp; &nbsp;: 7dxCJCfHe6GOILuDqAnKleB4iIfDSoVX</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;3EPP/wQZKWE=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
End timestamp: 2025-04-11 14:55:06 +0530 (run time: 0m 0s)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
And it was able detect changes made to the file (permission change) like be=
low:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Start timestamp: 2025-04-11 14:57:09 +0530 (AIDE 0.17.3)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
AIDE found differences between database and filesystem!!</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Summary:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Total number of entries: &nbsp; &nbsp; &nbsp;1</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Added entries: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;0</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Removed entries: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Changed entries: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
---------------------------------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Changed entries:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
---------------------------------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
f &nbsp; p.. &nbsp; &nbsp;. A. . : /lib/sample</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
---------------------------------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Detailed information about changes:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
---------------------------------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
File: /lib/sample</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;Perm &nbsp; &nbsp; &nbsp;: -rw-r--r-- &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | -rwxrwxrwx</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;ACL &nbsp; &nbsp; &nbsp; : A: user::rw- &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | A: user::rwx</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;A: group::r-- &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| A: group::rwx</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;A: other::r-- &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| A: other::rwx</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
But when it came to <b>bookworm (18.0.3)</b>, when I tried to add a file un=
der a symlink directory (/lib) and initialized aide database. The file itse=
lf is not taken as an entry in the database.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Start timestamp: 2025-04-11 02:10:43 -0700 (AIDE 0.18.3)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
AIDE successfully initialized database.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
New AIDE database written to /var/lib/aide/aide.db.new</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Ignored e2fs attributes: EINV</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Number of entries: &nbsp; &nbsp; &nbsp;0</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
---------------------------------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The attributes of the (uncompressed) database(s):</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
---------------------------------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
/var/lib/aide/aide.db.new</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;MD5 &nbsp; &nbsp; &nbsp; : pl93YpGJN9FrSnoqT0E3dw=3D=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;SHA1 &nbsp; &nbsp; &nbsp;: rPt7WKDC/q2REGf6zvHo5TYRXo8=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;SHA256 &nbsp; &nbsp;: +Vk/YPBigq7YMPdzEAa2BnhQKpKhcDgO</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ufnUJdXz+ww=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;SHA512 &nbsp; &nbsp;: wJrUxFj+aQ98FXzB3CgL0TuYips7zww6</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;FMMOvSOoReI5C+y5ESPOlwayxtY=
dFetu</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ksE3lSPfoZ0XRt0jK6tyUQ=3D=
=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;RMD160 &nbsp; &nbsp;: Q7t7ldGDvKL1dtkWebY7ADg5rF0=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;TIGER &nbsp; &nbsp; : Una57HNtE4LT2CtfSQm3/MJJHc0CcMf3</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;CRC32 &nbsp; &nbsp; : Iks/HQ=3D=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;CRC32B &nbsp; &nbsp;: 9KQcKQ=3D=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;HAVAL &nbsp; &nbsp; : Ew+OiFudOadA+OXb0OnlLF2dNM7/W3S/</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;GdxH7C3h4lQ=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;WHIRLPOOL : 65MSMeuSnYHCLCgWnMe4C1s8EPylzOVw</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ty4A+dG1kRseQRQbmT2RqAOwXgd=
0HOHs</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ipqJzSjmtcnxf+7Wgkdphg=3D=
=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;GOST &nbsp; &nbsp; &nbsp;: jcvRfvMgkH6BaQMTYegf8COtLbaMB/6i</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;TuLy7JXdZPI=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
End timestamp: 2025-04-11 02:10:43 -0700 (run time: 0m 0s)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
And eventually it was not able to detect the change as well.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Is this behavior introduced in aide from bookworm ?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
-- System Information:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Debian Release: 12.10</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; APT prefers stable-updates</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; APT policy: (500, 'stable-updates'), (500, 'stable-security'), (500,=
 'stable')</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Architecture: amd64 (x86_64)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Kernel: Linux 6.1.0-32-amd64 (SMP w/8 CPU threads; PREEMPT)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Locale: LANG=3Den_US.UTF-8, LC_CTYPE=3Den_US.UTF-8 (charmap=3DUTF-8), LANGU=
AGE not set</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Shell: /bin/sh linked to /usr/bin/dash</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Init: systemd (via /run/systemd/system)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
LSM: AppArmor: enabled</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Versions of packages aide depends on:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
ii &nbsp;libacl1 &nbsp; &nbsp; &nbsp; 2.3.1-3</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
ii &nbsp;libaudit1 &nbsp; &nbsp; 1:3.0.9-1</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
ii &nbsp;libc6 &nbsp; &nbsp; &nbsp; &nbsp; 2.36-9+deb12u10</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
ii &nbsp;libcap2 &nbsp; &nbsp; &nbsp; 1:2.66-4</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
ii &nbsp;libext2fs2 &nbsp; &nbsp;1.47.0-2</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
ii &nbsp;libmhash2 &nbsp; &nbsp; 0.9.9.9-9</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
ii &nbsp;libpcre2-8-0 &nbsp;10.42-1</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
ii &nbsp;libselinux1 &nbsp; 3.4-1+b6</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
ii &nbsp;zlib1g &nbsp; &nbsp; &nbsp; &nbsp;1:1.2.13.dfsg-1</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Versions of packages aide recommends:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
ii &nbsp;aide-common &nbsp;0.18.3-1+deb12u3</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Versions of packages aide suggests:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
pn &nbsp;figlet &nbsp;&lt;none&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
-- no debconf information</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_OSCPR01MB148381FFFE1BA2C392B96EE60C2BC2OSCPR01MB14838jp_--


