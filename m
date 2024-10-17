Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247F4D2126A
	for <webhook@archiver.kernel.org>; Thu, 17 Oct 2024 09:35:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.44512.1729157747314425115
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Oct 2024 02:35:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=QHu06zQT;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1729157707;x=1730367307;bh=oe
	ocA7PjlYeIKmNcmDAWgOqwnK27MBaquRQlZsPzofg=;b=QHu06zQTY9b4qBnnp0T3l4aOckwZRY10
	hDl68CJzHf3mYYYSH7YE2MoMxNtKCU09ToWS1e4W6XFVrLbBrWeZeZfaxUqIL3F3iDQhygU+Ij2YM
	I6L8o/fi0VDYU2nscCH5YAvnnxZ1ENRkC9E9+zvG/GmDJrZkjTwQff5qJLM0iDeBRQZF6/AOC2OSG
	WmSPFfC/SgY+fVGBAA2TOt/ao7k/Lh4rZvZ2+/Eyl938pdi0atSUkQwRzZIb7RQ2laG68WS8Uxy1W
	0iK/LAeYP8FUoARZ7t6mPIDvUB1FcVRJwi1+wuGcExG6hbW7hwXdIp4ND/xSJ+7s70zqlpB+Tcf5l
	8w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 49H9Z7ak663534; Thu, 17 Oct 2024 18:35:07 +0900
X-Iguazu-Qid: 2rWg67yeszpD4MPO7O
X-Iguazu-QSIG: v=2; s=0; t=1729157706; q=2rWg67yeszpD4MPO7O; m=+rkaQ2e0fvERjhloxWSWnu5TDXt4h2eCnU4yxWFXZCQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 49H9Z4uW2380898
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 18:35:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlmJDqZJr5TbPxKXygf7TRuYgAaD/fiyioA0nIBPj5VoKQjVMWm19mHNtK5wSIcFki8TmXe8YRY4yztts+ch6vDKIqzFF/58X9CjbRvkfHZqbSiBA8mHQ4rpYR1w/RgkLPF3HB8BPnp3HSbbjzi+rdwmpjtJi7Rfb49yb9fBfS0a8iWXCy+1haj3/jazLZEs9aoqcI7ox21AavkDQu5NhTWH3H3ibFIGnSLme5yoX5GyhyOIl56jkByyMEgHGNJ82RoXNccfU7dV/L0zziMHhdvK4q1AIlZyE8lWl+zGKHSa5/aWmh2J6Zh69O//n+iV6wzk/b+GLFTjwhvovyPh5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2b1VlqDh/K/ItfEXMqIyxxNgrtqFcQzzxsd4uKFI8o=;
 b=WqpX51+5DcpwO8RfZjcQxXfO13NJy4ukik3s4RmustGwgm86Ag4Cel58oZUG5Lj9bpto/kIuQnS671dcY7pq4juX8jhrOQpUAu/HDZEfqnsAIcTlgKSOvyk3DiKcSLMk0yVyCfaz+kOvJYrC/IypXzlLZn7hDYCsG/dZvBmnIvsreT2Qtri61MYZXgIVkZ6FoL4bUOUI6mTkWQAfsARVqqRBUuzYK90zGum7ELZ1xJ0crxu5vdTVXtKsgtTZkNks2tFMeOxEmVZ00pyQTosLsfHfwEkKznBXDspkiD2Mt++ZZRlmiO+HgK/4oZHIyGrzqHQv9Tnn4ubPnezrEoVang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <Chris.Paterson2@renesas.com>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>
Subject: [ANNOUNCE] Release and and v6.1.112-cip30
Thread-Topic: [ANNOUNCE] Release and and v6.1.112-cip30
Thread-Index: Adsgd8IUGKpgUnMDRsy5gSfwVEwfGg==
Date: Thu, 17 Oct 2024 09:35:02 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388AB9BB800028F4529C17692472@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OS3PR01MB5717:EE_
x-ms-office365-filtering-correlation-id: 9fab2339-0467-4d67-2551-08dcee8ef9a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?VXMzUWh2b1c2Qm96c2Y4ZmxyKzBVbi9zQjBuK1p3TkN6ZnZlUFAxWFlw?=
 =?iso-2022-jp?B?ZjROWXE5TS9KVmJLSUdnelJlS3dXRVhWTHU0VUtYbGhtVHREMWhDdk5O?=
 =?iso-2022-jp?B?OGJlV01DUlhHMnc2aUZTSmUxOWpFVGdCczhETVlCZ0Z0OUpFY1FSU1Nv?=
 =?iso-2022-jp?B?NklYM05ZQXFObTdiVFVYQ0thWHlObWFZaW5yeUFEV1dYWktZT0ErT2xS?=
 =?iso-2022-jp?B?cDJDY0ZZZEdOYjhmYktzZmcyT2xseG1yWGlwUUtRcG5KQW8rdHliemFS?=
 =?iso-2022-jp?B?Z2lnTXBJN1AyL1F3c3ZKVDlwRFZydWN2bUI5L0g4MEtEWW9FbVlnNCtR?=
 =?iso-2022-jp?B?UTV1Ti82RXpjVzRjemFmWjRBU2JmeHo0RGlSejcvVmFsczdUMGxSbmRu?=
 =?iso-2022-jp?B?Q2pkT2k2dXl5Vy9LdlNlTktaaXhSQVR6MDJVZFB4eU9zaU5JRmoxbnJp?=
 =?iso-2022-jp?B?VVh5TDl4aUFOK2JjUjBDSnVTbHNWMEtlRDJVUUZOUE5YUmNDditSTWZr?=
 =?iso-2022-jp?B?M2VYMUZNcEoza0lPdURmRUpsNHdQR21lSDQ0YjNjSjhqMUNpT0ZBbUZv?=
 =?iso-2022-jp?B?eUhtQ0tuUXFNTDUvblkxc08wNkZUMFJiTVR5UGh2VmVDV2M1TW5XU2lO?=
 =?iso-2022-jp?B?YW91TnN4NkJRYlk0Zml4dFBxclNGUE40Z0VyQ0V0eDFYUTd6djRkUUNX?=
 =?iso-2022-jp?B?T3ZHdk8ySnMrY2dXd3NNOVVSOVlpd3VIU3hJSkVCNlRmdHMxbDVHTG1V?=
 =?iso-2022-jp?B?NGExYTVUdFIyaXZmbkE5bjI2d3BqbUVwL1ZsUzRZajVSZnl5bGY5ZzJx?=
 =?iso-2022-jp?B?ZnhWeUJBbUwwc1dkZGp1UnMrRlZHM2ZPb3E0L0YxMG9pZS9EZHVJWVha?=
 =?iso-2022-jp?B?UGlxNkI2MGtWVFJxRnJ6QmRzNGgzdlFUeTMxcWFWcHAxVEdicGRaWkVJ?=
 =?iso-2022-jp?B?Z1VSeW42NU1EQ0lSYkI1dGIwNWZpajNPOW5FSVlZaDlHaUVlWUdyRnJR?=
 =?iso-2022-jp?B?Zlo5dThvZ3B3dlBGNXNtbm5DaHF6c3lsck90akl3R0FwMUtpQjc3azM4?=
 =?iso-2022-jp?B?TWFsR3NqVlAxaFdqSlhISEswMHo1WUdZTU9DNUZBYkxhK2l2ZkphcXRN?=
 =?iso-2022-jp?B?cy90ZjhKamovVE1uSnJjc3R4bW1lNWEzWG9UdmJGQ2pBZHNOSXpFMEhz?=
 =?iso-2022-jp?B?TkhhYktuaHp2ZlZpUnpqaGU4aEJmSWRhQ1MraDVIUEtQblBqVUZFNUd0?=
 =?iso-2022-jp?B?NkZxN0IxMUlyTFFwSzR1S2VuRFRMMHhLNzFlYmZSV0l4SVJoeGhERSt2?=
 =?iso-2022-jp?B?eUVoTk41eWxSUy9nRTh2THBrS2JhbTF4OW9wVnZ3dFB1NjBiVXBYc3E2?=
 =?iso-2022-jp?B?UlhIWStXdENBSFB2TDBlV2JuRDFENXdvM3ZWZTZYWjl4TEpybU1ZRzAx?=
 =?iso-2022-jp?B?U3dIb1E2bWlLRmVTL1hBTG9kTzIwck56L0FoRy84OGxFOXJHamsrMWxp?=
 =?iso-2022-jp?B?NkR6YmVwN1ZxS1djMzY2dERvOGNKVUlKMW90dFRlQkhhSHdPSElUTDly?=
 =?iso-2022-jp?B?eElsOFNEWnprclJ5ZDNmOWNkcHY4TlhrYVdHd2VRLzhjWjVtbS9Zd0x0?=
 =?iso-2022-jp?B?VUNNdnVuZkdaQkhpQW1TWFFKWW1VN2FSTzk3NkRFaXJJMUZwaWZwdzRr?=
 =?iso-2022-jp?B?aC9DNXYvZE40Umlld2NGcEttZ2kyaEtDaTNpNmtwUjY0UmFZalM2NTZF?=
 =?iso-2022-jp?B?K0Q3dG1Kc0ZSYmxWcndjZUw0SUFLeHJiVnFwSUswdGFuNk1ZSFA1eGhT?=
 =?iso-2022-jp?B?aXhYYVFQelB4UTlJN3haVHg5OTdSdkpHZzdVTGF1WTFQYXliKzN5bjZE?=
 =?iso-2022-jp?B?NXVadHhlQ29jOU9PRlNhd3o3V3ZDa0h5TGpqOUZmaDdVUnpOU1NPQmdl?=
 =?iso-2022-jp?B?TldNMklwR3FyQU1CUUpDU1NzUEhWV3BrNHV5dE1DcGlGKzZiTkFIZlRa?=
 =?iso-2022-jp?B?SHFwL0tIaXhScVZNS2JLbHhFRFBmYVlYd1JaZVcvTm9oNGdhYWhqRDFs?=
 =?iso-2022-jp?B?TUE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WmFUTytVN1crbmJDd2RNMU9ZK090N05hUUxJZ1NubHFyMlBjR0FWLytX?=
 =?iso-2022-jp?B?RW5jMXdlVGMxTjVuY0VyRFk4c3N1YU1wMHpRQlVXMVBrZUUzaE5lUU96?=
 =?iso-2022-jp?B?S0Qvb2pidmdpUjNTWGhFcTVJenZ3WEZwbXNISXdyK1hKYW9jbjVtNEFh?=
 =?iso-2022-jp?B?ZHc4SnNTTDQvaGtJaGl6VTNnSmJ4aHI0bDFsZGN6UHBSWWtQYVZrSHoy?=
 =?iso-2022-jp?B?VmhwQWdid01ReGZ6cFZ0MUNjTkhlN2VQT25HZXdUVER0d2xlWVNlUlFE?=
 =?iso-2022-jp?B?emlFZGJsSDRRVEJLNVFRaTdSN3hveEpTSys0RjNHM3p1Y2VLSnFnTWds?=
 =?iso-2022-jp?B?VHVFaHJZbU9KRGtBd0FSVGdoMHZaazlvSytIRzlZZ0VENjJUVHZycDNz?=
 =?iso-2022-jp?B?ZlJ4UEtuS3ZQNDExdkw4YjdsNWpsSkREZUIrNzZwdmVtQlh5L1ZkYkd1?=
 =?iso-2022-jp?B?TUdTMWlsNWpOZWVSVVFFYWs3ZVA2LzBjMlRNNVZXNC9zeHYxZ3J4cVZt?=
 =?iso-2022-jp?B?TDZYSG1BdTY2Yk40UzRsdGNmM3ZDTlMyRFQ1dVY2endGRHVUZGRJK25G?=
 =?iso-2022-jp?B?QkJiUnRlWnFWeDRjeVdqVzVyaFUvU0p5QnFCY0QzWG5HMk8xOXRkM3pq?=
 =?iso-2022-jp?B?c0JwdnFRN2prWGFML1h3YmQ2aTkwWEV4SFhpa3dVc2djL1d5V2tlSDJW?=
 =?iso-2022-jp?B?cksxRFgwMEZSdkxLUGFEUWdXNDlhZVlwZnhUU3IxZzRrNWdvd0phRGg2?=
 =?iso-2022-jp?B?MGxtZzYveTJOcVJpMzZtQ3A5c0VKMTdWZEl2SGl6UWtTMVpTV21aQlBZ?=
 =?iso-2022-jp?B?dzQ4QjZ4d1YvVjE0cnRhc255M0dOa3RjTVJpTmFyN2FOREhIbm9VR3gv?=
 =?iso-2022-jp?B?YWt5MURQVVYwL0pYZ0FMSGRGaXIzVHUwQkJnR3FxQlFtVHhZZTV4azdB?=
 =?iso-2022-jp?B?QXkzU1JLb2preGVzQjA5NmVxL3ozWHRYQzEyVzc3eXlZL0JGT3Fya1Jn?=
 =?iso-2022-jp?B?VzUyR1JQdjdLTHM2MGNHRjE4Szl1dDMzdzdVbnhCMnF5eUdnTlpWcllP?=
 =?iso-2022-jp?B?a2ZUZWoyTEhYUm1GeXN6dzRwSUU3ZWZrenU2aGpkbnBZemtBY3M4NmJr?=
 =?iso-2022-jp?B?ZWJMUVhrMnpaSjdwWU9WNzdsR0habkJ0ZHhQWm1yMldWTGtDdUNabUk3?=
 =?iso-2022-jp?B?UmdzaDlYZXI5YldkbHJoU0xzZU9Ob2liQXJsTllDenF4c2pxUzF6MTdC?=
 =?iso-2022-jp?B?NXgybWFDK3FiQksweG5JekYrN2FsQzliUHZ1dXk2ZDF2OFFVTXRXWUd6?=
 =?iso-2022-jp?B?eUIzNDQ2VmpJTTdydERvU3lmY1lYQkhyeWV6RXFqZVhPd3hoV1pPNWI5?=
 =?iso-2022-jp?B?ZUVVSCt0WmlsT2lOMXJSVkVXaTJWQWsyaWluY3pyMWl3bzRCZXNvdU4v?=
 =?iso-2022-jp?B?dnhqMGgvM0Q3S04vbmc5UkFFUGJqU1dWazI4MHJuWEQ5U0NJUzFlNDVP?=
 =?iso-2022-jp?B?VEpoaHc0VzFnM2k2b2ZpQ2EyQVBYc1FKMzhmWHAvTGF3ZTdTazhQc2lq?=
 =?iso-2022-jp?B?c3ZVWUJZRExkNDQ1TnVTSHozWGoxaHcxbnJNTkZCVDZ5YXZCd1c2MHNY?=
 =?iso-2022-jp?B?bW9DcUd6akc0VTF3WjBFT3hUT05rM2hvSXN6b0R5WVRzRDNGdmpOdisx?=
 =?iso-2022-jp?B?T1JqQWtrUTN6M0gzcGtXK3pyait1TUdHKzVtakc1bVVMQmNQc2llNXFw?=
 =?iso-2022-jp?B?TmQzYURWL2NTaDN4ZDU1c0FBSzZUcnJCTGdTcXB4YVQ3Rzh3SDlSM1BR?=
 =?iso-2022-jp?B?UmxDelo4OU5taFBua3pVY2hBdHdpTGhqUE95NlFHRnVoM0JsVFJJV1I5?=
 =?iso-2022-jp?B?cWp5ZyszVUcwZi9rMXkvVlgwODQ1MGRTM2N3K2diRFBTb05ObUZsdWU4?=
 =?iso-2022-jp?B?K2Y3WUM0NVQxVW1CajErWWJKM1k3MEZ5c3V6dkJLZFlEcGZTZXFzT3ov?=
 =?iso-2022-jp?B?ZHFhM1htcmRXaTdjR01IZk5kTlh6aEJDc2dvTEppRVA4cHNPSXR4TWxq?=
 =?iso-2022-jp?B?dW96dXIyZXlDRUJhcWlFeGY3ZENKL280enc4V2EzT1hyaGdCNDl1YUZG?=
 =?iso-2022-jp?B?cFMzQ1VUMWRHbldVZkZtMHFDWEJ0em8zM1FZZlMwTm9GU1hvRWtoTHZk?=
 =?iso-2022-jp?B?QkZaYThCOWVPUGNJTlNDOGhNeHVhd1NrWXRpRkp0QnZaMnYyMGtWMjlK?=
 =?iso-2022-jp?B?QWxLVSsvaFg1V3ZQS1ZMNDlqck5xNTJZZ3JLcmlNRkpTcVB1RG4rRTZp?=
 =?iso-2022-jp?B?WWR6UjQ4dG56N2xqZGU0N2NiTEpJdy9HQWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fab2339-0467-4d67-2551-08dcee8ef9a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 09:35:02.0726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knKQLsJyClvByj0CN/VXxFg5aVdSKzBrbnsZm22E13RDTbqxDI3F58YNFXDlJuGiKVbWqs/MLv1etN/es2OFS9UlACn77x+EvGATsKmT5ft93JcYZSlRCmMkvjwxFvbN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5717
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Oct 2024 09:35:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17047

Hi all,

CIP kernel team has released Linux kernel v6.1.112-cip30.
The linux-6.1.y-cip tree has been updated base version from v6.1.111 to v6.=
1.112.
This release adds updates to drm, sound, and DT for Renesas ARM64 SoCs.

You can get this release via the git tree at:

  v6.1.112-cip30:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      11191e768f66acff530e944b15a92415f8a46386
    fixed CVEs:
      CVE-2024-41016: ocfs2: strict bound check before memcmp in ocfs2_xatt=
r_find_entry()
      CVE-2024-44931: gpio: prevent potential speculation leaks in gpio_dev=
ice_get_desc()
      CVE-2024-47671: USB: usbtmc: prevent kernel-usb-infoleak
      CVE-2024-47670: ocfs2: add bounds checking to ocfs2_xattr_find_entry(=
)
      CVE-2024-27017: netfilter: nft_set_pipapo: walk over current view on =
netlink dump
      CVE-2024-47672: wifi: iwlwifi: mvm: don't wait for tx queues if firmw=
are is dead
      CVE-2024-47673: wifi: iwlwifi: mvm: pause TCM when the firmware is st=
opped
    added commits:
      CIP: Bump version suffix to -cip30 after merge from stable
      arm64: dts: renesas: rzg2lc-smarc: Enable HDMI audio
      arm64: dts: renesas: rzg2l-smarc: Enable HDMI audio
      ASoC: dt-bindings: renesas,rz-ssi: Document port property
      arm64: dts: renesas: r9a07g043u11-smarc: Enable DU
      arm64: dts: renesas: r9a07g043u: Add DU node
      arm64: dts: renesas: r9a07g043u: Add VSPD node
      arm64: dts: renesas: r9a07g043u: Add FCPVD node
      drm: renesas: rz-du: Add RZ/G2UL DU Support
      drm: renesas: Move RZ/G2L MIPI DSI driver to rz-du
      dt-bindings: display: renesas,rzg2l-du: Document RZ/G2UL DU bindings
      media: dt-bindings: media: renesas,fcp: Document RZ/G2UL FCPVD bindin=
gs
      media: dt-bindings: media: renesas,fcp: Document RZ/{G2L,V2L} FCPVD b=
indings
      media: dt-bindings: media: renesas,vsp1: Document RZ/G2UL VSPD bindin=
gs
      media: dt-bindings: media: renesas,vsp1: Document RZ/V2L VSPD binding=
s
      clk: renesas: r9a07g043: Add LCDC clock and reset entries
      ASoC: sh: rz-ssi: Add full duplex support
      media: platform: rzg2l-cru: rzg2l-csi2: Add missing MODULE_DEVICE_TAB=
LE
      arm64: dts: renesas: r9a07g0{43,44,54}: Move regulator-vbus device no=
de

Best regards,
   Nobuhiro


