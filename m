Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E396EC36002
	for <webhook@archiver.kernel.org>; Mon, 24 Mar 2025 10:16:21 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.21])
 by mx.groups.io with SMTP id smtpd.web11.35766.1742811377752750658
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Mar 2025 03:16:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=G5YApltn;
 spf=pass (domain: renesas.com, ip: 52.101.125.21, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aK3GWlmgy5FTiOljUaqUrW/jjqQkDinNZ9HYUDUcXEGc9aM8RnRjF6wNlPhzRMHH3aO/gUGh4NZ2zdjy9X+1HnmJZxhprqK0FgOmjLpuOgfHiqLLrWh3ec+bBwQkPzJH74IgPfD4iTjyQWJ7iXypwpPKroJH3hoyqdyiyjWwqAjG3yKUc+jMRx/KhTy8MbsxoEedsgzBwia+uHpQu80k9UITdUS7d6hdLD+6XUN75fCdpNxu6r5YnEDWXBmyLiAl8aU7rJ7KacKdPLsyG1ul+cE/C7R3cCM5E9N80UnyF7zahOt6/iX0a/BqruuAXJxFdf7BSuK15Dc/RBs5JLDznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQ0o2wgwgV0o6STFicdR8Yqm+Jl12+RwzdkgSFB3xEw=;
 b=oaEnIS0psrDzZOX6+WMZIm4uKgUoGvC9gCRMq+DYISdqCSZtjfsNKU4EHURt9PGcGLu/bhb+ZuaWGqAbqqWunfCBNwB7SXggPgbKeNqT0RXEwufayqrFMPViPh7L1OmLqg++TzkdqIqY24MM9qH6Tj5kd0w7/vKBnCeBz+7miKX+1bm1zU8XeZ1MFFqu47+B2CSo7kpqw3Di6BNdZVQ/ku9dNQ8vP82ncwr05pdUWnVHtyI79Z168LYba2gdjRUux4hwMIOT84h3HAUrUjeVMUmK/rTtUEGqbpfVxWnLPy5Qgj4cN3y/uZt+Y8Mp31UJgZASJ06uysbkiIS6MKzFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ0o2wgwgV0o6STFicdR8Yqm+Jl12+RwzdkgSFB3xEw=;
 b=G5YApltnf0bDV98lQ9oFD9rfYnQ3bmY5MAZuMPKEOIOyMASNqhYm4xUG6OYMAZHn18X61mXAHDbbHSHPkKYIuLkSpmDvqVKamzz+clam3xsGu7CFNALAFFRzrKU7pzbjuKAB0TIir4W1TNbIGQ4EERVVz/2qwxUmOlebYsff8+k=
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com (2603:1096:604:c6::8)
 by TYCPR01MB5854.jpnprd01.prod.outlook.com (2603:1096:400:40::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 10:16:13 +0000
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b]) by OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 10:16:13 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Shivanand.Kunijadar@toshiba-tsip.com"
	<Shivanand.Kunijadar@toshiba-tsip.com>
CC: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"Adithya.Balakumar@toshiba-tsip.com" <Adithya.Balakumar@toshiba-tsip.com>,
	"Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: File server for zchunk swupdate update
Thread-Topic: File server for zchunk swupdate update
Thread-Index: AduXPMDwGbkQ98swTHSVcGfABwDcxwFaGtzQ
Date: Mon, 24 Mar 2025 10:16:13 +0000
Message-ID: 
 <OS3PR01MB58966EB75B7DC1FEB3851792B7A42@OS3PR01MB5896.jpnprd01.prod.outlook.com>
References: 
 <TY3PR01MB11075908DA987ADCDE33DD899C7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB11075908DA987ADCDE33DD899C7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5896:EE_|TYCPR01MB5854:EE_
x-ms-office365-filtering-correlation-id: 04bea167-320a-4cb6-ab94-08dd6abce7da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|7053199007|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?NWNiQW5aUHk5M0I0QnBxcXFFdGhxK2RFbGkxTmcvUWhxMUhGTDNpWlRD?=
 =?iso-2022-jp?B?QlRJL2Z6OEtqK01ITzlkZ2FXRlo5aGNINUQ0aFpoU1JHQWpKcFkvNnFK?=
 =?iso-2022-jp?B?ZS9tNVdBUFBXWU1aN1Irdk5GdWh4QUtRbU56N09VV3pNYXlVQy9Idk94?=
 =?iso-2022-jp?B?dXpiTnFaVzZwc1JZeG1rQ2JLakRnWmd2S2Q2ZnJaTXltbDNYNmN0UHpS?=
 =?iso-2022-jp?B?cjd2SWxENE10WEtYV3lUK1RqZ0hacUpTekFUZXEvcHBZSUZ3azNuTzBB?=
 =?iso-2022-jp?B?a09zRU5mWUJIUVhIM2c4azNXbmowOXNBcmdpK0RaNjA1U21MZVZHS01K?=
 =?iso-2022-jp?B?N1FydFZoRG1KSEVhSzVVTnUyKzJabTJLTmEyaWxaRCsyYnVqMC9zbysr?=
 =?iso-2022-jp?B?amJWck1hUlZ2bVg4WEkraWJDTUp6a2htbjZQMS9rMmpkRDNoL3IxaTFJ?=
 =?iso-2022-jp?B?T2ZsMS9yVnJMSU40aVI4WldSanFyVlYzVFhSYnYyZThMQmNGeC9LcHdK?=
 =?iso-2022-jp?B?VFRndlQ3cjZTMUlKWDQ4d2RwSlFrWUdxSHZBZUVRcW5BNEY5Z0NDMk00?=
 =?iso-2022-jp?B?UERDcFAxYnNxWHdGVEVKYjJBeTNRajR2eHJ0UzNpbUZNWU5waWptZUlz?=
 =?iso-2022-jp?B?NTJzWkU1c3NwZFM4bldkRjYxOHpXN0VDZDVpRDg4eTNuU2lJNWUyam43?=
 =?iso-2022-jp?B?dWRyMGd6QndaVEUwUEprNElScUI3UFIyUHFyY2hCbkFtZ2wzQTJoN2pY?=
 =?iso-2022-jp?B?RGxEcEFPUHNmQ2U2U1dkL1RsZXJKbTk1ZWxENG9QNjNocm0xOVNsTlI3?=
 =?iso-2022-jp?B?YlFZOFYxSnc2QnRwV2c0YzE3ZkxIU1c4aXpudVNKamdsZWlJdzlPaS9a?=
 =?iso-2022-jp?B?bGpaL1RpWWw4djEwOXpvZmx5VVRxTFI1b0tBMm9QU2c0WU92L3ZWdG5l?=
 =?iso-2022-jp?B?TXc4VFNVNm9YSjhBTzdBNndTTkQvQlZnUGVQS0FlNjlXSmlISHUvM1Zo?=
 =?iso-2022-jp?B?cDFqOWh3SEdqOHlScG5wVk9SR0JwdlJkWk45L0pHc3ptNVVEV0x1ak5G?=
 =?iso-2022-jp?B?enFNUFlveTZhTWlHdzR6bUM0b3hUeVFvRTFmdFRQZjRXcFVFSmxtcTZp?=
 =?iso-2022-jp?B?SXphSnphOW9EZFVuQ2RxWTF2ekxjamt2MDJ4d1pHREVQWjRwTXAxYVlF?=
 =?iso-2022-jp?B?dy9NeElOWU1jRjJJbXhabzQydWdaVCtQSCtNQ09YUUlrREp0T005Zitp?=
 =?iso-2022-jp?B?Q29pSkVQUUs0Wm9jeTAwNlZ5YitpZ3RMQnBJWWdQaHRmUG8yemtQRUxK?=
 =?iso-2022-jp?B?RW9wZmpiR2Z4cDVaRWFOMTVnSnJES3NFRmZQWTc2QTdUV3pzV05qN01C?=
 =?iso-2022-jp?B?dmcvWjdsdDE5M3JacGdQcEhCdVU1M2RhK1JzRGZXUGU5VEVYTFdNWUpm?=
 =?iso-2022-jp?B?Vis2N05temZnZTY2YnZPbWFrNkFmOXZJV2hmbnhZR24yNlh6cWYrY0tj?=
 =?iso-2022-jp?B?RHlZTU1teEREcjNxTk9FNms0NmtTV09FS2xiYnFLbENjZndNRktCVjZ4?=
 =?iso-2022-jp?B?TnBqY3JRTG43dmhvQWtUVDZucm1FeEducVp6UzQ5ZXhWOThRdWtPdVoz?=
 =?iso-2022-jp?B?d2JhOTZrVjZRdGh6UXY3QURZT2t1ZEExejJkUmNla2Q0Y1h4dERaVnZx?=
 =?iso-2022-jp?B?Um1Mbjh3dkw1dDN6dDhqK1NVNXorandpQUJ2OEdCbk5sYTBBOTM0Qiti?=
 =?iso-2022-jp?B?aFJXL0hPQWlHaUlZb2lsUjFtTVNWRGZjOGZueGtZOUtmTzMvemJWTGVN?=
 =?iso-2022-jp?B?YzZaK3ZEVG1YdHJyWWhNVGRwczdiU0tsM0NnVFo2eDV3em5wKzBLVUto?=
 =?iso-2022-jp?B?RjJwRllKZHRRYUV4Wk1oV1RxNy9UT1U1UVVTa1RqRkZBOFFQelcyWU03?=
 =?iso-2022-jp?B?S2pENktEU1JKVUE5NXlqZmduc0FNN2xleDdqVFVWbEZlQzJJZ1lhdEhs?=
 =?iso-2022-jp?B?TFBsalM5VFJvZDJiYjkraEM0L0QzTmRRMHpzak9EcXgza2I3N1UxNWhh?=
 =?iso-2022-jp?B?NWpVdVlIUnowanRWU1RKeWlXVEhKL0p6aGlGUUZVdk90L2U2cHdVK2lG?=
 =?iso-2022-jp?B?eGs=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB5896.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(7053199007)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QzkyWEJvbEpTd1YvY21zU3NZcHpJbU1hb215OEJ2dnhYUkZ4NTJRWkpi?=
 =?iso-2022-jp?B?Y3NyQzdkM3Y0azFVOFM4ZGswaStvaVhHN1RrUzZCUHVQT3p6ZHBTSjZI?=
 =?iso-2022-jp?B?VElESjJRUEJ0ODgrYWpaZTlyQ3ZMZ1R6RENkYWVxODhpZDZRU1FTcDBx?=
 =?iso-2022-jp?B?RFl4dGxmU1dQa1hTUmtMNEwvbWpnekNwb2dQUVBkTlo4c01MelRldEE5?=
 =?iso-2022-jp?B?MXhQc3NrcE5YM2JxUGo0cCtxMXp6U0c1N2s4djlGNU0zMk0xc3A5WGR2?=
 =?iso-2022-jp?B?bFRUYythNTBLaWNhQXVUNVpWS1YrSVNIOUlqRG1aWkdTdThxSlRPQXli?=
 =?iso-2022-jp?B?MFpjRGtUTXhqRm90aUtTTVQvTEJmakFLeUJhZk8yN3RTcnlQdWdQRGpV?=
 =?iso-2022-jp?B?M3lvMjRjSUw4L1h5ZnZIUzJIK1EwWEJHVzZVTnBrKzFHSk5TaTB1NU82?=
 =?iso-2022-jp?B?TlZKK2owaElKdzJsa3pGU1hkT2xGSXRaaUcxWldLdjZXV3hjeTR4YVpB?=
 =?iso-2022-jp?B?WEc4dk13VlZrVEREN3FlMkxmT2tsbjdvRzZQb3ZYR2RHTGhFdEJSU2JH?=
 =?iso-2022-jp?B?TU5PYkdjejh3UGdHYkNnUzJaTWh5Rk02QlpkU0QzS1dQR3RUay9EeEhJ?=
 =?iso-2022-jp?B?TVFBcFNmVDJmMTNFYTJQL2c0ZFJhOXZLTEJqV0w5MUZqU1lUYnNCMGov?=
 =?iso-2022-jp?B?VXlsREZzZGp6VG9ERDY0SGQyTTcvWWpheDhYYWxrajdwS3FqR0pOdGZa?=
 =?iso-2022-jp?B?NURoejRQUEFZUjhJaGRIYVdkVGZ4SDUvVDljSEwwZmExemFueUR2dExM?=
 =?iso-2022-jp?B?T2QxVlpoK3FjN0dRc0tmNnhLTlNJMmxxQW5zenhZbXRka1FOdS81blR2?=
 =?iso-2022-jp?B?MjB5Zk91bEV5YVU4RUxpTjdSam9VNThYa0MxYkhybUFrYmY2bzZXWmcx?=
 =?iso-2022-jp?B?V3BjVTVPTnN0YVhiK2w1TXZhMGdvU2Z3eUpWMzE4N3lKVjVURnQrTGZQ?=
 =?iso-2022-jp?B?RERzZEdzWFAvS2JWRVZhN3ZIeEh5cEgwaURaRGkwclRCclVmUUg2WGF1?=
 =?iso-2022-jp?B?WWpWK096eG1SSnlZYzVjUWtwZXJNQW9aNnFzaHdoRUVrUnM5a1NNMm9E?=
 =?iso-2022-jp?B?aW9MME9uVStRUmwxczFXWSt6REdxLzFkRlF4bVg2ZExEa2xQejJ6d3Fh?=
 =?iso-2022-jp?B?VEw4cGJnaXdHTThUbVRmZHRCemUyK2U2UHdvRjVFYzNoZ1Z5SWNjT2p4?=
 =?iso-2022-jp?B?YlQvRHBiZnk1R1FPdTYwK1RkdmEyem1QYkgwOHUzUUZvcDlWYjZmb00z?=
 =?iso-2022-jp?B?Tk96Q3FQMWtWdGt2T1RrRGFiMnFzUWpzVFZ5Nk8rQnduSzJnOHZkdURB?=
 =?iso-2022-jp?B?b2VHRVpiY25saTVBU3B3TDdwWUJSdEFlelZHVkZRYkE5UWpWZXRpZ3NR?=
 =?iso-2022-jp?B?N05TQm9tMTdWaHRWcTB4Q3JiVklLUUdlT1ZYYmgzYXVudEtETU93L0pQ?=
 =?iso-2022-jp?B?bzc4Q1VMVEVPdUtoQ0JMZFRwNjBsbm15UXhyM0ZiMXRvcGE1UVcyUXBR?=
 =?iso-2022-jp?B?K01GZkxUNWwxVW9uS3JSYlNtMnhmQW4yMHhBcXRWUjN5VmNjSXJxVUVN?=
 =?iso-2022-jp?B?N3cvdGNDMTAxMFNQVHlNNXVIWFdxZWpHMnhESVY5RkJXcFRsYjFFYW1t?=
 =?iso-2022-jp?B?VnhpWmdFd0REQVlVRDJTWEV6VTRYKzFPcFZyVmJQWmR3MzkzQ2JJM1FO?=
 =?iso-2022-jp?B?REZ2dk5rN2FOL1hoZXNRZVBrZWlrWkxZOVdZa1haZ20ybzlOU2RQMTVD?=
 =?iso-2022-jp?B?WitaM3VBeGNRT2VybDh4ZmIxZHgvMFYrRHhqRmFoSGhTaVZncmlnZ2Ra?=
 =?iso-2022-jp?B?MGlvd3dKME1GT2JTL200ajRnRys0MkYyemxKUXVpQi9zanhLMjJrTEgx?=
 =?iso-2022-jp?B?YUk1TUp1MEw2UGZUbWdhVnova25KbmVBUWo0WGZtYktYTnFyaHJtNDEz?=
 =?iso-2022-jp?B?NjJGV1hFeVR6azJHRm9kMGY5Q3Z4emRWQXB5WEQ4NFR1dTlQUnlGWG1P?=
 =?iso-2022-jp?B?ZkhobEkxZkd1d3BhY1JoTTMwUzBhZlZsc2FKRUFHckh3Q0Z4eHFoRzVC?=
 =?iso-2022-jp?B?Zm91UXB1L1M5dnl3aFhZY0pyanJFd0lxM1g1ZnVUZVR6bFMwZGJsLzBq?=
 =?iso-2022-jp?B?dEVORytKQW9iYXM3aEJSY2tVd1pvMFJ1SzVHZmRXZ051K0VSKzhTQnoz?=
 =?iso-2022-jp?B?MnlmM3Q0aTVyODc4VEdFOG5OekxzQ0N2MGpWSWJoV1pta0E5RzFBQ1Zu?=
 =?iso-2022-jp?B?TG14T0hUOU9WbnVBZ0c0SG1yckMzL3NXWGc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB58966EB75B7DC1FEB3851792B7A42OS3PR01MB5896jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5896.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bea167-320a-4cb6-ab94-08dd6abce7da
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 10:16:13.2427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xe+U+w7owKo9nFBb4yroQuHs393o/MR+07+dxXLWqxYJI7lZF377dZCcCv4VzSbdpuXBcW5Ci/Yxv5BqEG2Ahe4cHTKTMKWrglDt+kDZXEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5854
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Mar 2025 10:16:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18338

--_000_OS3PR01MB58966EB75B7DC1FEB3851792B7A42OS3PR01MB5896jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Shivanand,

I think the CIP core group just did something similar for a WFX service?
You could go down the same route for zchunk. Either by using the same serve=
r or in setting up a new one.

Either way the only people with admin access to install things are the LF a=
dmins.
You can create a ticket with them through the LF helpdesk: https://jira.lin=
uxfoundation.org/plugins/servlet/desk

Kind regards, Chris

From: Shivanand.Kunijadar@toshiba-tsip.com <Shivanand.Kunijadar@toshiba-tsi=
p.com>
Sent: 17 March 2025 13:57
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: dinesh.kumar@toshiba-tsip.com; kazuhiro3.hayashi@toshiba.co.jp; jan.kis=
zka@siemens.com; Adithya.Balakumar@toshiba-tsip.com; Sai.Sathujoda@toshiba-=
tsip.com; cip-dev@lists.cip-project.org
Subject: File server for zchunk swupdate update

Hi Chris,

This is regarding the zchunk based swupdate verification on LAVA lab.

The zchunk based update needs a file server where we keep .zck file and swu=
pdate requests multiple byte ranges based on the requirement.
In manual test scenario, this has been verified by keeping the file in Apac=
he / nginx file server.

In LAVA lab, I also verified zchunk update by installing Apache / nginx in =
CIP image itself.
In the last CIP core meeting, we discussed to use some container to host th=
e file server (Apache or nginx) for this purpose instead of installing in t=
he CIP image by considering the package size and maintenance.

Do you know any EC2 instance where we can run docker container with nginx/A=
pache for this and should be accessible to LAVA lab?
Or do you have any other ideas/place apart from EC2 instance for running co=
ntainer?

Please provide your opinion.

Thanks & Regards
Shivanand K

--_000_OS3PR01MB58966EB75B7DC1FEB3851792B7A42OS3PR01MB5896jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#7030A0;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0">Hello Shivanand,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0">I think the CIP core group just did something similar =
for a WFX service?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0">You could go down the same route for zchunk. Either by=
 using the same server or in setting up a new one.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0">Either way the only people with admin access to instal=
l things are the LF admins.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0">You can create a ticket with them through the LF helpd=
esk:
<a href=3D"https://jira.linuxfoundation.org/plugins/servlet/desk">https://j=
ira.linuxfoundation.org/plugins/servlet/desk</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-ligatures:none;mso-=
fareast-language:EN-GB">Kind regards, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">From:</=
span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans=
-serif;mso-ligatures:none;mso-fareast-language:JA"> Shivanand.Kunijadar@tos=
hiba-tsip.com
 &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt; <br>
<b>Sent:</b> 17 March 2025 13:57<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> dinesh.kumar@toshiba-tsip.com; kazuhiro3.hayashi@toshiba.co.jp; =
jan.kiszka@siemens.com; Adithya.Balakumar@toshiba-tsip.com; Sai.Sathujoda@t=
oshiba-tsip.com; cip-dev@lists.cip-project.org<br>
<b>Subject:</b> File server for zchunk swupdate update<o:p></o:p></span></p=
>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Hi Chris, <o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">This is regarding the zchunk ba=
sed swupdate verification on LAVA lab.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">The zchunk based update needs a=
 file server where we keep .zck file and swupdate requests multiple byte ra=
nges based on the requirement.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">In manual test scenario, this h=
as been verified by keeping the file in Apache / nginx file server.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">In LAVA lab, I also verified zc=
hunk update by installing Apache / nginx in CIP image itself.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">In the last CIP core meeting, w=
e discussed to use some container to host the file server (Apache or nginx)=
 for this purpose instead of installing in the CIP image by considering the=
 package size and maintenance.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Do you know any EC2 instance wh=
ere we can run docker container with nginx/Apache for this and should be ac=
cessible to LAVA lab?
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Or do you have any other ideas/=
place apart from EC2 instance for running container?
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Please provide your opinion.&nb=
sp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Thanks &amp; Regards<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Shivanand K<o:p></o:p></span></=
p>
</div>
</div>
</body>
</html>

--_000_OS3PR01MB58966EB75B7DC1FEB3851792B7A42OS3PR01MB5896jpnp_--

