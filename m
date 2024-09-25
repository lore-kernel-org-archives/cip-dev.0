Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4295FC369D3
	for <webhook@archiver.kernel.org>; Wed, 25 Sep 2024 11:43:57 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.59])
 by mx.groups.io with SMTP id smtpd.web11.13824.1727264628353263141
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Sep 2024 04:43:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=WSUG35OH;
 spf=pass (domain: renesas.com, ip: 52.101.229.59, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5VG4+UGXSv8jPxwz0m2dduGmNdv600ZlCGRnfPelCp/zTR31hVXqz8lZ33FheHpxL0evnmem9RETjpAhJSVOlcRPGGznSoWMGjI5oKyr5ZTGSnRQMvPX7FOn+ezqxTV9LdvWGfOM5woKCyCO+Hw/GRgE2huLFAeZimcTWTGMd+AnWDf17nabTsZrS7RMaS6uRixLV9EieoLEjTfEQVdQ1N/vdX24NwSYIRrGfdWoj0J/m0hNiDmnm/OjS1nYQTZj5sSWy/Iv3shfoGIGqK83x1mOuUL1fNvDGWdANYu4l0AtjjPzex49XS6lFbxUelECuqLkQ8ayzMO15pNXo4OIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hb95JbVcknJ7yixevea3OkhjJ9XqMoA5eXSHplLEEc=;
 b=nQD36YVL9eyZhzWslMYrFHmbId2vuTCuhuyQRrJ0V1KhKm8KwAsIGgOH6eDNoiZvLCtv2iRR37+oe0o0ww2aAan1ak7JRKHiVJOXF5cMVLDn6GVwFGTuaEv/9DY6YLiAVy3Zp+aitqPXIsYz1jUBXf+wXf//HniGkVbQVoL1LNvRNxOgKYXY8vIbTm98bttnOZLuyNXGny0aYnPTD75xsYcSBpqafouogZ8iBcRYVke9/QwV4CCx6fgyJTZ3Z6zn+ZsuI/ClwC/lHdEomRJR+i9MxS0JmidHvmDgv7J3xdgUFyasdgdfT/j4xsRvT4FzsRZy7moyIp+jhkyolEKeuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hb95JbVcknJ7yixevea3OkhjJ9XqMoA5eXSHplLEEc=;
 b=WSUG35OHgHlQL9Io7qTqUjPV5L1Biz4u/03sQY3pkKT9gsCCQXsdfbQYqdtVFb+cfrOzEL7MYNxu6pWX+BvUfDBHDb+3UKWDIsK1YokmsZQkJ4vkv7HRhZdWzLTyvSPfFPu1hbf1ZhpvyUFhO0TzzuW/HJ918FOPwP5wP2HfzSc=
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 (2603:1096:604:2e2::10) by TY3PR01MB9776.jpnprd01.prod.outlook.com
 (2603:1096:400:229::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 11:43:43 +0000
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f]) by OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 11:43:43 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>,
	"michael.adler@siemens.com" <michael.adler@siemens.com>
CC: "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Issue with 'small' Gitlab runners
Thread-Topic: [cip-dev] Issue with 'small' Gitlab runners
Thread-Index: 
 Adr6EQ3RL8rQAtQSSy+tF4/i30H+FAACvaEwAB6AvfAAoAnrAABqrZEQBBtW1XAAAKEVoQAAz0Ww
Date: Wed, 25 Sep 2024 11:43:43 +0000
Message-ID: 
 <OS9PR01MB12389DB1E8371D5A1747C9094B7692@OS9PR01MB12389.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103DA72FFDEBC407A5900A6C2962@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB12402CF459412685A6824CB45B7962@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <OS3PR01MB610349E8EFC2F9E8ECEBD450C2972@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <cnkp47rzuahu7yls5ch2mi6okr6w3uevw6eqehmc3ti3f6zesu@of6ittbitant>
 <OS3PR01MB61035250A83977730E393D70C29C2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS9PR01MB12389D4A1AC2973E4C3AF27FDB7692@OS9PR01MB12389.jpnprd01.prod.outlook.com>
 <OS3PR01MB610365D7958F2829214B6BF1C2692@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB610365D7958F2829214B6BF1C2692@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12389:EE_|TY3PR01MB9776:EE_
x-ms-office365-filtering-correlation-id: 4903a2df-ecef-47fb-8ff7-08dcdd574ed5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?b2dYbUFqT25oN045U0EyZmlaNXRqUDJsRmIzVXlqb0lZeGdMWTVxajcv?=
 =?iso-2022-jp?B?N2FwcUFlcnZIY3NReSs1V29udkJVMnFzVWUwU05ZZVlrNkJaTVhiRkto?=
 =?iso-2022-jp?B?RzJLYzNlZ0hCaGhUeWZ1dUFROG5RTGJLbHVtS1lQZXpCWHQ5NnZZRmVQ?=
 =?iso-2022-jp?B?TXhXdXF2WU54aSs2MEY5ZTZZbENlSjlTRDFwYU8yUXkrUjVEMjBkcUw2?=
 =?iso-2022-jp?B?OXIrMUU0dVk2S0haNXhSV3c3ZHBiRE9XY09zRU5NckhwaXRwd3A0Q0do?=
 =?iso-2022-jp?B?YytYekNQQ2prOXJkMzFKWWltMGtpbkFVMGI2RjFzMmk3UWsyWGpja0ti?=
 =?iso-2022-jp?B?cnAxejloclNraTdhV1Z5Sm9yK1VWb2xHb0JOSWhJc3ZRaDdOb1lrMTBp?=
 =?iso-2022-jp?B?ZHVYQy82WDR4QXhqMkNKMnFXVmN5ajZ2NTNwcWZZbEFuRjVNYXdBSzdV?=
 =?iso-2022-jp?B?ZnhRM1UyZ3FnTTFtajlERXNBOWpXNlVYdUlXUEFUOE0yUEgwTDMvcUUx?=
 =?iso-2022-jp?B?N0JsbjZSbUtnc1BRSHZpMXQ1eDVGL1J2ZXpDUkRuY2xjZjVZdUVnbkFZ?=
 =?iso-2022-jp?B?a0hpcG83OElWSUlRWUNzWWpSdlFHR2dyZnJuVUEwTnZHZGZPaU54V3F1?=
 =?iso-2022-jp?B?UFRHa1lINXJsMjJMbDNWdUYzU2k0RHZWRHI4cUNLWWcwUkJBRVZwQ2pV?=
 =?iso-2022-jp?B?ZGd2aU11ZlZjQ3dEMnFKSmtlM3gvWE1vbGRYK3l5SUtROVRUdVAzR3g2?=
 =?iso-2022-jp?B?aGRzd3ovWi9iVXZIQUhNb0UyczV1bVJuTndNVFdPN0VaZjE0QXVyNGZT?=
 =?iso-2022-jp?B?L2UvYkhxNWdsdjBjNjJ1dVgxdDJJKzM0ZTgxMW5Ka2NvQmtvdVNxLyto?=
 =?iso-2022-jp?B?cDRib3ZYZUJtRlNJWWxuNktoZ3QxNGF3ZC9xZkhMcUV2bjducjhFbnVQ?=
 =?iso-2022-jp?B?Sk92ckVJS1dzeUNSSEd5OWZDckFxSVNRTVkybzN6Zi9meG9aN1I5dTlU?=
 =?iso-2022-jp?B?NkNJOVVmbS9JYmVTZFRUK1NDbnJhakZZZ2lOSTJnRFlNMVE2bEdsUnli?=
 =?iso-2022-jp?B?bXNDVkw2VUFvNkEyQ0t0TWZ0SjdCVzlpNlJQZE9jREVhemROcTlBUDgx?=
 =?iso-2022-jp?B?bWg0b0o2RFJMK0NYVkJVbVFmQndMeGV5RDhrTU0yV0gvOW1ONXo0MURL?=
 =?iso-2022-jp?B?Y3BQYUNxZ2YwZGtNaHZDSFFtRlkxL0NyMW4wS200YnQ5SVFHRm9CaVhL?=
 =?iso-2022-jp?B?TnZValdMU2hyVEZPaG42c1ZjR3hQUTgvd0piOENyZ21ITWYreHlnS0hZ?=
 =?iso-2022-jp?B?eE1JTDBaVEZJL2ZidnlQZEdDc29PUkNPSFdpK2thL1VKVzNDbnRZenVN?=
 =?iso-2022-jp?B?ZUZQOXpsYklQK3BEeW1IVVZXZ3hDakduVWxkTGJLdGFDR2YxdXJwOFYx?=
 =?iso-2022-jp?B?RW1nS2thZXVKL0dyWHltQnU5a2NrRE9KdkpUN2x5OE1BY0I1OE9OcXNh?=
 =?iso-2022-jp?B?U3FXOGZOVWFnQ0VCZmxWTkNpaFdnZFdJRE1BZUFvWXdsS1Bkai9aenJl?=
 =?iso-2022-jp?B?RWhQT2pYNm8zVE54VjI2OGpMUnJ1ZGJteU83Q2ZkTGlzclRkSnNwQ3lo?=
 =?iso-2022-jp?B?aHhZTXZ3cjIxVm1VeGRiRWQ5VXpwZURocmhNZ3BRT2F5WFFwOTYzOExS?=
 =?iso-2022-jp?B?dnczcVFUMFFlTFlqeGp5MFJxaUIraGx2L3VBSnU5V0Y5WFhyaHZ2Qmww?=
 =?iso-2022-jp?B?akF4VEdYR0VWOGRLTHpMTytMSE56Vzg5U2h4N1IwUnRCODlNSEdTRlhv?=
 =?iso-2022-jp?B?NzNzd2tEbmhuTmUvUkdNTUJMSU4vM2NvamVicmk2Tkl6eVhVOVROT3NM?=
 =?iso-2022-jp?B?UWVrTEJ5c3ZQNEVwRkQvcm9NWFpFPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?N242THhxZ2JwNmUwSllFWllLaitVbVpRRFZWVXZrNk11VmpNb0xJcUNM?=
 =?iso-2022-jp?B?eWZtN3RUT1lWV1c0cE9LUVJnNVR1QjAydDREQUhaZHE5aHlEbzVUQnp2?=
 =?iso-2022-jp?B?RnNkMmVJRFBoRVRXbGs3Z0ZUMUk3Nk1oMHhBYjJRd3BKWjhuU2tZTDZU?=
 =?iso-2022-jp?B?MThTQ3NWc1FlMVVnK2huZ1gzaHptd3M5bGtLeHd5ZmZoajBXNFpPb09j?=
 =?iso-2022-jp?B?RTBEa1JoSk1xZDM4R3lqdzlPeDdLTytNS3VhZTNKRWJJSXk4QjNjOE1Z?=
 =?iso-2022-jp?B?UkhyYW1kdmlMSG9XbGxTS3Y0SlRPM1dPUTI1U3NQKzZUcHZWWDU4QnI0?=
 =?iso-2022-jp?B?bG9jWmF0cnB5TWR4ZHE0c0Y1SmJPeDU0WE5jdFhaakRjY3Y3SDhXK3NL?=
 =?iso-2022-jp?B?c2FrMkZ5ZCs3bGt5a1ZuRkJtT2h3MXhCL2s4dFpCSzB6Y1M0UWx5eE9H?=
 =?iso-2022-jp?B?QlRWa3dmY2xwdUZEbjBiUlppNWNBRmUyeW0wdGhsQW8wSlhCb2VIWHhW?=
 =?iso-2022-jp?B?QkpHM2liYWwyejdFV0tVQUFkdGxRTy80alVCRCtmVWhXOGZmZXhCT2dL?=
 =?iso-2022-jp?B?OWFPalFMNTFVUG5TZjNGalE0VmgzNEpzOWVkdDNlVjdDQ1FJVDdiZzE1?=
 =?iso-2022-jp?B?YXBuN0Njd1p4bEwwcjloeTczdXF3dEl6K1phcnRmd2Q2RnpKajVoNno4?=
 =?iso-2022-jp?B?RWdvT2ZWZ0U3MnJPeU1PTnlkVERQQTVqUFh4S2x6Y0tuMXJXWkt2eStv?=
 =?iso-2022-jp?B?dHgxRmZOejBXRXBRenNJc2sxamZ5SlNEa0g0eUFCa1RyZW5XbTVOeG1G?=
 =?iso-2022-jp?B?OU9Fa2tsUTQ4OFhjVGFpbDA1bjZUaXdIZ2M3RGpZOEZhcHBqNFZMU2dn?=
 =?iso-2022-jp?B?ZFdUUGVCeXhodU1GbnpkMkhGZFlnM1VjK2JLQXpxejB0RkdNdXdObnVW?=
 =?iso-2022-jp?B?WkZqL2VLM3JHWDhuOEYyYmhpQnJCRGJoSUF6enNSUCtsandSZmp0aVpj?=
 =?iso-2022-jp?B?cklTZFNrN3plNjVGTmpJL3RFN05TMEdHWG9QVS9tazY2MDNlWVBkSFJL?=
 =?iso-2022-jp?B?bTR2WTh3MndKT3R5WXRLdUltRXpaeE9YeVpMcFJ2VUZGVXh3YzAwWU42?=
 =?iso-2022-jp?B?SUdnNkhEOFNoL1JMREhOOGRHNExCdFdRWG1VTHRqR2NSd1lzaTBTYTk0?=
 =?iso-2022-jp?B?ZmQ2RVp6dWRVS2p0eldpUi9TRG41ZFU5NDJLUlFnUkpWNkxqZ2xUK3l5?=
 =?iso-2022-jp?B?eHFBNFRBNEtPaS85dXhDTXJYdnplU2h4cEVTWFpSdjF6QUdHYkhVOXpX?=
 =?iso-2022-jp?B?dVQ0TG8ybldodnd2RlN5RVlXRUFVM3JJcjB2dVRmcWRPQzNVcXgwQmNT?=
 =?iso-2022-jp?B?cS8yZDF3ekNGSkJ4Rk1nRHpLM2pycW5BZ2gzb1hCbFlGVkhBQklsQ1dH?=
 =?iso-2022-jp?B?UFVoSnNKOGh4dEh1MERGc09MTXczQlRVZ3BzOUpJcDQzcWZ5VDdrZ2Qy?=
 =?iso-2022-jp?B?ejNnWFJUY2NyK2t4OFFqQ1VlbEVEdk8yQXBCZUtLQ1JtSmRKSkErdVVz?=
 =?iso-2022-jp?B?Rld6MzlnZTh1UStDbHI4aHNCTlhpcXFIVC9Fa2tWdjhMVmdGbkE0S1Z6?=
 =?iso-2022-jp?B?RmNhQW1iem83VlFOLzV5MjBzRlhENXU2UWpXM3pXM1JmT0d0N2FKWTl0?=
 =?iso-2022-jp?B?b2dSTWk4K0x4aWtYYWVJMUpXeHhRSjd6aUp6c0ttSkxseE14Q091VkVW?=
 =?iso-2022-jp?B?YW9VaVlDYVBOTUJZbnhtS00vNmFOVFZCd2xUbGNoQ0s0SzkvbXppZmNM?=
 =?iso-2022-jp?B?dkdOam9xdVJhMkxYM3FqRkdDT1dxbXVmK09EamVZMG42TXdRbmljWDRm?=
 =?iso-2022-jp?B?S3k2MmdrQWppMUNIZ0hDbjNRdTVTTkc2Y3g0R1Ria3g3YUxvNUFURWlw?=
 =?iso-2022-jp?B?OGJrQ29sa1JKcEVTd3dSMXlPYXhPWEh2M0FQOGVsVnNHNFYwSjlkWi9G?=
 =?iso-2022-jp?B?TXRZMTNpNC9tWElOZG56b0tiQzZxQ0g1RkZRWE9LTnpGaTRmZjBEaWY0?=
 =?iso-2022-jp?B?L0J0YmovZndnMjd0RHJCQUx4RHdzTEdIUytHQXhmTG9DMDRTQU9OcU1j?=
 =?iso-2022-jp?B?bXIvZHNPT1F6dU9HRjN3cnJDZUtXNU1nMDJGejNYcUhMNTVsYUQyeVlw?=
 =?iso-2022-jp?B?L2ZZNWlqYmJkV0d0SUJsbktiRHYvUWxlWE9qMk14NlNBdWZHM0tXYk5l?=
 =?iso-2022-jp?B?ODhSa2FxZ3l2S2NVVmd1ZWJBTVZSTUJiQ05CbjlXZ2FnT0VnVzRPc054?=
 =?iso-2022-jp?B?a25pc3h5VWRTaU5wOGljOUpuM2p6ejUwb0E9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS9PR01MB12389DB1E8371D5A1747C9094B7692OS9PR01MB12389jp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4903a2df-ecef-47fb-8ff7-08dcdd574ed5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 11:43:43.4056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpaEjgqm7EUcQ06QIOwbtHSwPLAe7CAFMh4hRqsy1zyryLgMMJ6azb6iiaVyOigU9BFuU65mdYJgBPvDJVbd+qxwcTbVFow+KT7d/6DzUe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9776
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Sep 2024 11:43:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16916

--_000_OS9PR01MB12389DB1E8371D5A1747C9094B7692OS9PR01MB12389jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Sai,

Do you know how long the cve checks normally take?
I=1B$B!G=1B(Bve set up my own branch for some debugging and the =1B$B!H=1B(=
BChecking hihope-rzg2m-buster.dpkg_status=1B$B!I=1B(B line seems to take an=
 extremely long time.
Either that or it=1B$B!G=1B(Bs done, and now it=1B$B!G=1B(Bs doing the aws =
s3 sync that=1B$B!G=1B(Bs done afterwards, and this is the step that is tak=
ing forever.

Indeed, looking at your job linked below, it took 49 minutes to the point w=
here it failed.

How long does it take to run the cve-check script locally?
Outside of the specific issue you=1B$B!G=1B(Bre seeing, if it=1B$B!G=1B(Bs =
very CPU intensive then perhaps we=1B$B!G=1B(Bre better to use the =1B$B!H=
=1B(Blarge=1B$B!I=1B(B runners?

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
Sent: Wednesday, September 25, 2024 10:57 AM
To: Chris Paterson <Chris.Paterson2@renesas.com>; michael.adler@siemens.com
Cc: kazuhiro3.hayashi@toshiba.co.jp; dinesh.kumar@toshiba-tsip.com; cip-dev=
@lists.cip-project.org
Subject: Re: [cip-dev] Issue with 'small' Gitlab runners

Hello Chris,

This issue is still present in small runners. I ran the cve-checks job toda=
y. https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7885795173#=
L655

It still shows 'Job failed (system failure): pods "runner-zwslwy9eu-project=
-10191315-concurrent-0-ulyylb1h" not found'.

Thanks and regards,
Sai Ashrith Sathujoda
________________________________
From: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Sent: Wednesday, September 25, 2024 3:06 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailto:=
Sai.Sathujoda@toshiba-tsip.com>>; michael.adler@siemens.com<mailto:michael.=
adler@siemens.com> <michael.adler@siemens.com<mailto:michael.adler@siemens.=
com>>
Cc: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro=
3.hayashi@toshiba.co.jp>>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Portin=
g) <dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>
Subject: RE: [cip-dev] Issue with 'small' Gitlab runners

Hello Sai,

> From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.co=
m> <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
> Sent: Wednesday, September 4, 2024 12:53 PM
>
> Hello Michael,
>
> I ran this job multiple times recently. I am seeing 'pods runner-
> zwslwy9eu-project-10191315-concurrent-0-2fdr4qlb not found issue' again
> while using small runner. https://gitlab.com/cip-project/cip-core/isar-
> cip-core/-/jobs/7740352129

Are you still seeing these issues?

Kind regards, Chris

>
> When I run with large runners, the job is successful ->
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7742283984 .
> That is why I suspected there might be an issue with small runners. Can
> you please provide your opinion on this ?
>
> Regards,
> Sai Ashrith Sathujoda (T S I P)
>
> -----Original Message-----
> From: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>=
 <cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>> On
> Behalf Of Michael Adler via lists.cip-project.org
> Sent: Monday, September 2, 2024 2:28 PM
> To: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
> Cc: Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@renesas.com>; haya=
shi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B
> =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mail=
to:kazuhiro3.hayashi@toshiba.co.jp>>; dinesh
> kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m<mailto:dinesh.kumar@toshiba-tsip.com>>
> Subject: Re: [cip-dev] Issue with 'small' Gitlab runners
>
> Hi Sai,
>
> > I thought there might be some issue with the runners as the job failure
> message said, =1B$B!H=1B(BThere has been a runner system failure, please =
try again.=1B$B!I=1B(B
>
> maybe there was a temporary issue. I just looked at the cluster and it
> seems to be (idling) fine. So I'd suggest to try it again.
>
> Kind Regards,
>   Michael
>
> --
> Michael Adler
>
> Siemens AG
> Technology
> Connectivity & Edge
> Open Source Embedded Systems
> T CED OES-DE
> Friedrich-Ludwig-Bauer-Str. 3
> 85748 Garching, Germany
>
> Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim
> Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and
> Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Thomas=
,
> Judith Wiese; Registered offices: Berlin and Munich, Germany; Commercial
> registries:
> Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE
> 23691322

--_000_OS9PR01MB12389DB1E8371D5A1747C9094B7692OS9PR01MB12389jp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
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
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
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
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Hello Sai,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Do you kno=
w how long the cve checks normally take?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">I=1B$B!G=
=1B(Bve set up my own branch for some debugging and the =1B$B!H=1B(BCheckin=
g hihope-rzg2m-buster.dpkg_status=1B$B!I=1B(B line seems to take an extreme=
ly long
 time.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Either tha=
t or it=1B$B!G=1B(Bs done, and now it=1B$B!G=1B(Bs doing the aws s3 sync th=
at=1B$B!G=1B(Bs done afterwards, and this is the step that is taking foreve=
r.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Indeed, lo=
oking at your job linked below, it took 49 minutes to the point where it fa=
iled.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">How long d=
oes it take to run the cve-check script locally?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Outside of=
 the specific issue you=1B$B!G=1B(Bre seeing, if it=1B$B!G=1B(Bs very CPU i=
ntensive then perhaps we=1B$B!G=1B(Bre better to use the =1B$B!H=1B(Blarge=
=1B$B!I=1B(B runners?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-GB">Kind regards=
, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> =
Sai.Sathujoda@toshiba-tsip.com &lt;Sai.Sathujoda@toshiba-tsip.com&gt;
<br>
<b>Sent:</b> Wednesday, September 25, 2024 10:57 AM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;; michael.adle=
r@siemens.com<br>
<b>Cc:</b> kazuhiro3.hayashi@toshiba.co.jp; dinesh.kumar@toshiba-tsip.com; =
cip-dev@lists.cip-project.org<br>
<b>Subject:</b> Re: [cip-dev] Issue with 'small' Gitlab runners<o:p></o:p><=
/span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Hello Chris,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">This issue is still present in small runners. I ran the cv=
e-checks job today.
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/788=
5795173#L655">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7885795173#L65=
5</a><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">It still shows '<b>Job failed (system failure): pods &quot=
;runner-zwslwy9eu-project-10191315-concurrent-0-ulyylb1h&quot; not found'.<=
/b><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Thanks and regards,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Sai Ashrith Sathujoda<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Chris =
Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Paterson2=
@renesas.com</a>&gt;<br>
<b>Sent:</b> Wednesday, September 25, 2024 3:06 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"JA" style=3D"font-size:11.0pt;c=
olor:black">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-size:11.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif;color:black">) &lt;<a href=3D"mailto:S=
ai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsip.com</a>&gt;;
<a href=3D"mailto:michael.adler@siemens.com">michael.adler@siemens.com</a> =
&lt;<a href=3D"mailto:michael.adler@siemens.com">michael.adler@siemens.com<=
/a>&gt;<br>
<b>Cc:</b> hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font-size:11.=
0pt;color:black">=1B$BNS=1B(B</span><span lang=3D"JA" style=3D"font-size:11=
.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
</span><span lang=3D"JA" style=3D"font-size:11.0pt;color:black">=1B$BOB9(=
=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:black">
</span><span lang=3D"JA" style=3D"font-size:11.0pt;color:black">=1B$B#D#M#E=
=1B(B</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;=
,sans-serif;color:black"> =1B$B!{=1B(B</span><span lang=3D"JA" style=3D"fon=
t-size:11.0pt;color:black">=1B$B#D#I#G=1B(B</span><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">=1B$B""=1B(B=
</span><span lang=3D"JA" style=3D"font-size:11.0pt;color:black">=1B$B#M#P#S=
=1B(B</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;=
,sans-serif;color:black">=1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font=
-size:11.0pt;color:black">=1B$B#M#P#4=1B(B</span><span style=3D"font-size:1=
1.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-s=
ize:11.0pt;color:black">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-size:1=
1.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> TMIEC ODG
 Porting) &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar=
@toshiba-tsip.com</a>&gt;<br>
<b>Subject:</b> RE: [cip-dev] Issue with 'small' Gitlab runners</span> <o:p=
></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hello Sai,<br>
<br>
&gt; From: <a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@=
toshiba-tsip.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">=
Sai.Sathujoda@toshiba-tsip.com</a>&gt;<br>
&gt; Sent: Wednesday, September 4, 2024 12:53 PM<br>
&gt; <br>
&gt; Hello Michael,<br>
&gt; <br>
&gt; I ran this job multiple times recently. I am seeing 'pods runner-<br>
&gt; zwslwy9eu-project-10191315-concurrent-0-2fdr4qlb not found issue' agai=
n<br>
&gt; while using small runner. <a href=3D"https://gitlab.com/cip-project/ci=
p-core/isar-">
https://gitlab.com/cip-project/cip-core/isar-</a><br>
&gt; cip-core/-/jobs/7740352129<br>
<br>
Are you still seeing these issues?<br>
<br>
Kind regards, Chris<br>
<br>
&gt; <br>
&gt; When I run with large runners, the job is successful -&gt;<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/job=
s/7742283984">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7742283984</a>=
 .<br>
&gt; That is why I suspected there might be an issue with small runners. Ca=
n<br>
&gt; you please provide your opinion on this ?<br>
&gt; <br>
&gt; Regards,<br>
&gt; Sai Ashrith Sathujoda (T S I P)<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip=
-dev@lists.cip-project.org</a>&gt; On<br>
&gt; Behalf Of Michael Adler via lists.cip-project.org<br>
&gt; Sent: Monday, September 2, 2024 2:28 PM<br>
&gt; To: <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip=
-project.org</a><br>
&gt; Cc: <a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Paterson2@ren=
esas.com</a>; hayashi kazuhiro(<span lang=3D"JA">=1B$BNS=1B(B =1B$BOB9(=1B(=
B =1B$B#D#M#E=1B(B</span><br>
&gt; =1B$B!{=1B(B<span lang=3D"JA">=1B$B#D#I#G=1B(B</span>=1B$B""=1B(B<span=
 lang=3D"JA">=1B$B#M#P#S=1B(B</span>=1B$B!{=1B(B<span lang=3D"JA">=1B$B#M#P=
#4=1B(B</span>) &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazu=
hiro3.hayashi@toshiba.co.jp</a>&gt;; dinesh<br>
&gt; kumar(<span lang=3D"JA">=1B$B#T#S#I#P=1B(B</span> TMIEC ODG Porting) &=
lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-ts=
ip.com</a>&gt;<br>
&gt; Subject: Re: [cip-dev] Issue with 'small' Gitlab runners<br>
&gt; <br>
&gt; Hi Sai,<br>
&gt; <br>
&gt; &gt; I thought there might be some issue with the runners as the job f=
ailure<br>
&gt; message said, =1B$B!H=1B(BThere has been a runner system failure, plea=
se try again.=1B$B!I=1B(B<br>
&gt; <br>
&gt; maybe there was a temporary issue. I just looked at the cluster and it=
<br>
&gt; seems to be (idling) fine. So I'd suggest to try it again.<br>
&gt; <br>
&gt; Kind Regards,<br>
&gt;&nbsp;&nbsp; Michael<br>
&gt; <br>
&gt; --<br>
&gt; Michael Adler<br>
&gt; <br>
&gt; Siemens AG<br>
&gt; Technology<br>
&gt; Connectivity &amp; Edge<br>
&gt; Open Source Embedded Systems<br>
&gt; T CED OES-DE<br>
&gt; Friedrich-Ludwig-Bauer-Str. 3<br>
&gt; 85748 Garching, Germany<br>
&gt; <br>
&gt; Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim<br>
&gt; Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and<=
br>
&gt; Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Tho=
mas,<br>
&gt; Judith Wiese; Registered offices: Berlin and Munich, Germany; Commerci=
al<br>
&gt; registries:<br>
&gt; Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE<b=
r>
&gt; 23691322<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_OS9PR01MB12389DB1E8371D5A1747C9094B7692OS9PR01MB12389jp_--

