Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F93DC27C77
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 07:31:37 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.53])
 by mx.groups.io with SMTP id smtpd.web10.6068.1718350294199430245
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jun 2024 00:31:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=jWMJz3d5;
 spf=pass (domain: renesas.com, ip: 40.107.113.53, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1EH1WFbDj0aVSL3YNe2xRCeHK2XTPz4QhPfBGp9FrwWxPc8oEmT/uCrUmsX58OnAnNENiQSvXwG/zsTKkcrvl2Y1D4DkKs2Yn6J999xDmtatMu9xj/ixgb+RHN0BDT2ioUEIWCNbO5cz/nWJooKorJqMj7FVEbK4GT3Nxm0z5lvuAU1YYV1wAsQdjbmPK3SkQJ9Riow6PWo8w1as9gyeSFi3/kIUANtB1bMixBRDQdudY8qO1gSS/ikgw+C4Pm8pIVS8ej7/kKMI6GLBM1TWLVBH2mD/OJe2gOLxMxXzS6MOaIQd5oPRBWM32914/4M7vGt3Zi9qv8Fw3MJL9HzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DUqztU2MPzlitVv0u1tT1JMdcHsqOR/wJC/wiPyQQs=;
 b=S5Czo/qIuz+dhqOA5gZxNJ8aocEeG3eGx1Sq36o+PWi8xON/QFJiwXb1zMAcW7zEsG2ZUOnSz7n4fjRLbr5BJKctMySiTc0h1CAKybjAm9xzd9EGGcRLHG96EP2oHvyUXkZvQ1QT1JZnhNcP1kk82jWzoHwh1TParTfj26tmkhkKIIZiYyQDZowguuTm6dcc7/CQcl1Jh7MzyLo3XDGMM2NAQjVB5ToUZtEfD5GNV7mQwGalv0oBlko/d103K5oFEbKdXIaFwQNTAs6sg+KZWrvdhm1OgRb6R0ZwcsPzjmjVIUtYfo5OXx5aGwK1CF/PEBV61pzcemYTBNZ+19N+bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DUqztU2MPzlitVv0u1tT1JMdcHsqOR/wJC/wiPyQQs=;
 b=jWMJz3d5WwgfBKROJeOnF8hwZ9TfYIWAvLnN1rSdGdR6XD2PVGXGQqIXj9uIoRUJEN8dvlfyr/0dvDSDE36C2khUwNux2R1DhhWU5DDd4nvCkQSh4Bfre8wfR0RtvHumkIhQsHbsL9UvmtIx77fvk8Fkp5imr1eFOupgxd+gG8s=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by OS0PR01MB5409.jpnprd01.prod.outlook.com (2603:1096:604:ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 07:31:29 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::1bc:6d4b:6770:82c9]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::1bc:6d4b:6770:82c9%3]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 07:31:29 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
CC: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Artifact download failed due to timeout in 'lab-cip-cybertrust`
Thread-Topic: Artifact download failed due to timeout in 'lab-cip-cybertrust`
Thread-Index: Adq+DRGNdZZqn7OhQqy7wVWWG8yu3AAHlugg
Date: Fri, 14 Jun 2024 07:31:29 +0000
Message-ID: 
 <TYWPR01MB1186229B58F2B4E702B4688E7B7C22@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB61030B7550E645EED661DCEFC2C22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB61030B7550E645EED661DCEFC2C22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|OS0PR01MB5409:EE_
x-ms-office365-filtering-correlation-id: f50de1ce-9ce0-4aef-9663-08dc8c4401af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UU5oTFp5RUFaRVhFK2YyZzU1TVNhaW9sazdGVTNEU3ZVSnoyZGdtbnVJ?=
 =?iso-2022-jp?B?b0p4dm5iK28zNldMdlBVUVgyTFdvbUI2MGRZanA4aFM3eUVHVXF0QkhK?=
 =?iso-2022-jp?B?V0FLQ0NzekQ3OEY4WjZuajFqTHNmc1ZRY2JJYTNnNllZYVJ6ckl1dDEw?=
 =?iso-2022-jp?B?NkFxd2p3d1ZNbXM0NGIzRXpSV0pHVGFFVjFFWWZyTmhZM1FnSTFQNDRi?=
 =?iso-2022-jp?B?T045VDVzMzkzMFdVWmlFUVBiVHg5YzZqZWpDK3BLaHhGOG9lYmVLQ25I?=
 =?iso-2022-jp?B?OU5XYm9zbTNLcFNwbE5ZU3F6dm1XT1FOREc2OUtxYXZ2ckdlTVYzbVJQ?=
 =?iso-2022-jp?B?SGZrak90RDhiN05lQXBCczhxeDQzR0FET0lGcVJCenhPVk5GendEMEp6?=
 =?iso-2022-jp?B?NkF4TTNzcHp5aHZWci9qRVhUeGttR1pjYU9MWExvV3hDL0NJdEdkdjJ2?=
 =?iso-2022-jp?B?THg2N2ZsMEcwcHNqd3I4MmxKUkNWMW9CcE9SQXpvOHVxQjRHYnE5MlZ1?=
 =?iso-2022-jp?B?ZndUZG56bEFVZExZNk85WmpwZE5WZDZHbFNNbFBMYzhTSXdOdkY1VTVQ?=
 =?iso-2022-jp?B?RWtXaE9ZRHVqeEQ0aWMyT2VMQVFFYkp0c1lFSHIwby9FTkkzRzd2YzVN?=
 =?iso-2022-jp?B?RXA2bERRK01iT2Z5dzQ1bUs4VkVCL2ZxZzhjcHZwZTY3MXJMMzFab0Q4?=
 =?iso-2022-jp?B?NFZzSnZubG9oUlg0ZzdYVzFjMFhadkFSajFxYS9yQUV5cnhuTDQ3ME04?=
 =?iso-2022-jp?B?MVkyU1VPSGMzVUNka2FhenhJd3d6S2JsY1p6bnh6dk9KOExvdE1ickl3?=
 =?iso-2022-jp?B?ZGVHZjA3UEhxaDBtL2NwcVM1emkrbVBrNm5OcURMWjR4bHFCZDMwMVpC?=
 =?iso-2022-jp?B?TW1WeksxTHpPMUZCa1pyMnkzVnpQNUhUem5FVUNTYmFGTC9ZZzkrdkhu?=
 =?iso-2022-jp?B?d0p6S1QvcUFMTUdTaG4yQTRjN1lnRVlVaVN6aDZpWUI5QTkrRG1DZzBu?=
 =?iso-2022-jp?B?QWZxaUFEb0pXSzc5OXJPMUFvcldJZUpyUTVEMzluVmhrOUUxbW95aUFM?=
 =?iso-2022-jp?B?akRGeHFOZVJKbXgxN2tlSzRMTzM5Ri9PVzJiOCt4a1FYYXZNbVp0d2JI?=
 =?iso-2022-jp?B?Vk1nZXRXWm02WjlGblZTandwcllTQTVIdldkSWRqU2o3cW0wSmNic3p3?=
 =?iso-2022-jp?B?SURpRmRnalBYa1J5R1dMMFN4bGluU0JQVVpzT01lc3pJaHZOSzdwWG9N?=
 =?iso-2022-jp?B?eksyQjBQdmFRWTlxWUJCa2pZaGdRWDhSNENyc0FvZE01dklDMUdJYlBn?=
 =?iso-2022-jp?B?MGJjQ0g3ZS9aaUdIblhlL2x0cVkyK3B6WlU2ekh5RkF3N2J6cUc5K1JV?=
 =?iso-2022-jp?B?UkFTRStMNHFaOXIwa2k0N25vVUhqc1NOS05tYTFwRFd4QWN6Q0tONTd0?=
 =?iso-2022-jp?B?Tnp0RHZ4Q242cWV2eU1hWVR1a1lENVFXYnVHWmhaemlqNEMzaUloanVs?=
 =?iso-2022-jp?B?Y1ZKT1ZmNlhZVVJmVkNHYnlZSFdjTkhUVEMyZUNlRWhidzZEaHBGRGxa?=
 =?iso-2022-jp?B?dFJTN001YUZuZEUrVUEyVmxSeEhXeUhRUlpMdUJLQVRuTGtyUXY4S3Vk?=
 =?iso-2022-jp?B?WFNvMy8vb0FuTWM0TWdPVnBueGczbm5xOFZDb1prYlliK0hQUERsUW9o?=
 =?iso-2022-jp?B?bkN3K0Y1UEVQZzRPcUhGVkhkcXp4RzFDUWhET0N2MEpTY1F4TDczRzE0?=
 =?iso-2022-jp?B?OUdGSmdBeldBa2xKT3VoUEgxaHpXN0I4R2F3T04xQThoMFVzSlc0VWlS?=
 =?iso-2022-jp?B?RXJpQ0NmUE9QeUVDazI4VTcvMmg2a2tQbWlzeXNFdUpnN0lNQk1TbWIz?=
 =?iso-2022-jp?B?N2wyaHFZUWdueDNvVEZ0WUZnbS9zeDRIWS95Y0t6ZFkyY3V2YVF6aUQ4?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NVJ6ZWxxZytRdWZMdDZjTW50TE5UeC9lV1FlZzdyYy96K1p1ZE5PM1ZQ?=
 =?iso-2022-jp?B?eG9pY1ltKzJWak5jdXNjTEZueU1KL2t3YVQwVUhZeVFHWTVDd2hnVlJ6?=
 =?iso-2022-jp?B?NU1aVFk3K25ETlNINkVYREttNFlaWXFUajQrRXIwaktna0xBVWg0Ym01?=
 =?iso-2022-jp?B?MFF6VUpSZXIwak1NZ3l3dkVIa0M1RWhVdG1WR1JFVy93dkFzc3l1S21k?=
 =?iso-2022-jp?B?amNkLzBxV0p5b29wUE1GdVlhSGF0YVZENWh4NmgvVkdxMXk4Mk4yS1p6?=
 =?iso-2022-jp?B?MTduVDhqdjc5d2hrTDdPanRtN3FtQWV4OVNoT1NQSk10UitaVkRqWXQx?=
 =?iso-2022-jp?B?UE1ZSlJBNlgwZmU0Yk5GTVFvLzZzNkQyUkJWWFpzV1BBWU54Z1M4OVRr?=
 =?iso-2022-jp?B?NGxXdVBFYmpPdUdYS1l3cHZoWkZoNFZKcTVyeEd5UlFJVmRQQ0JkYjhy?=
 =?iso-2022-jp?B?bGpFUzMxL0NxRDdxeVZVRjVHTVlmejVuRGxrNmFoc1V2c0cwazBVS1hk?=
 =?iso-2022-jp?B?Q3BwQThTcXFLOHdRUUtVaWRpV3BrUkxCYXFCa3hnRG93QTNVemhSZms1?=
 =?iso-2022-jp?B?WUdrcU1LTEJadUxZSkQyQXJQS3hPSWhtcDlhVFlzN2NPY3RzQTF1YzFN?=
 =?iso-2022-jp?B?UHRIdHI0VlVTQWZzTDRRZUw5cTZZanIvWEJUb3lOVEkxT2dQbGRyWjI0?=
 =?iso-2022-jp?B?VmVSL2MxWVJYT0swMnliNVdaTzZuVmpVcGNxS3l3ekZEdEs5M1YwLzky?=
 =?iso-2022-jp?B?Y2VqcmpsbU1xbWsvN3gvejN1Y2IwUk95ZktvNW5iU2N4dHRxcU1BcHpj?=
 =?iso-2022-jp?B?Q3NHTVI4OFdzd3NISGFsbW83WFVpait6M3c3cEF1eTRCcmROQU00V3B6?=
 =?iso-2022-jp?B?My9TckIyK2R4bzBZdTZGZVhwd016ZU14ZGVWMXArVis1QUkvNVVqQXhR?=
 =?iso-2022-jp?B?RjlZeXJoOVdQNHlUd2duUDc4dUhwU0FKb1F3bmYwWXdYMU1LdmRCUGx6?=
 =?iso-2022-jp?B?ck5VV1c3aXdBc3VJaHRNaThHc1prUWZqckFGc3Y1ZW1XZlpBbWQ1N1Zi?=
 =?iso-2022-jp?B?Q1V2VDIrd3FmKzU0SHhFZDJnNzhzMjdxN3l5ZThzcDFqRUs1MllpMFc3?=
 =?iso-2022-jp?B?ZVJWY2MzeWY5WmxOOGdVdnhORFowYlB3V0EyVWx4ZDVYbDZKUGVzdytV?=
 =?iso-2022-jp?B?OGwrM29LelJST0pkcUw4OTZ4VDgyK3JiV1MyRlRFVlhiQTFlTFNQNzJZ?=
 =?iso-2022-jp?B?MUl3NUN0c2N5RHFnNE53UmlkOGxXb3orU0tJYWdNNW80S3lKcENWSmZo?=
 =?iso-2022-jp?B?a0x2bnlpQWFnejI2c3lMNDI4QlErNkkrYUt1TzR2NXZUM011SFJ3UXFC?=
 =?iso-2022-jp?B?N0FMdVZ2YWIrc0J3QmVhUk9kMlFSa3JBWmFMNzlEKzY4VFVESmV2Ymc5?=
 =?iso-2022-jp?B?QmJPVUVmNmFnTnlGY1NuVzE5SU1JeVJLYnp5V05PZ1VsMlQvL3NvUE12?=
 =?iso-2022-jp?B?K0JCVmFEN1JFNWFGSkdTR285bHRwQzRuQ21QRzdheFlsendIajl2bzls?=
 =?iso-2022-jp?B?cG9xWVFZclJsSFY1UHlpRzhRWW01OFBpZWszaUhKT2FxZDBDSGJPSWZ2?=
 =?iso-2022-jp?B?N3dRU1FqNHZpK1ZaTFMrK0MvcUdMUXNKV3F5Z3dZbXc5NEZlOVpZRnhI?=
 =?iso-2022-jp?B?Z21tUkNWRGdDYnFob3VNbU80QlFXRmU3ZFFwQWxmUXpaVnlJNGRNV0p4?=
 =?iso-2022-jp?B?QWtoOWNXYTN6Z2l3djUyT29xSzF0WTlsWFd0Z0MzSzAvOVpvY1l1eVVp?=
 =?iso-2022-jp?B?NEcxS3RROW9NSTdHeFI1Vy84QWl1MEd4QVJsUEJtdU1ERkFrb0tZcGg2?=
 =?iso-2022-jp?B?Q2l1dVIwV2ZIcDlPQUhaYmZHRHdDNkl1OGVqZjh1VW1vaWhZUHVnTHVs?=
 =?iso-2022-jp?B?WWNML2dpRjh2Q2E4d0pOblphM0R6R2J4QVZyamNWVENpUENCMU9kTzdU?=
 =?iso-2022-jp?B?VEozY1Jhc1ZiMUFZTkF6bnBKNlpKYlppRnJ2b09RM0hRQkZocElhdjB3?=
 =?iso-2022-jp?B?bXk1TTQvTWpIdU1ENnZpeER3NW53bzdOTHRhTGRMUVkzTS9QRWFLUTNt?=
 =?iso-2022-jp?B?SERIVW9sUkNUaUNTZTBObFl0SjNXOGNLWWpnL1hZdk5xbksrNFNsUHFz?=
 =?iso-2022-jp?B?YXhaVzdsYXBQbWdCRjlzcTZNeWs5S0lWV0t0V1ZqaWlIRGVqQmpyVko3?=
 =?iso-2022-jp?B?Qlk0MDE3SFhvVStvZG5sRWV3eG9yTEgzSWk5UHRHbTBDMUJKVXJEUTZZ?=
 =?iso-2022-jp?B?Qk04SitKNk5yQUxJNHRqOHQyNzhjNzkvekE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYWPR01MB1186229B58F2B4E702B4688E7B7C22TYWPR01MB11862jp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50de1ce-9ce0-4aef-9663-08dc8c4401af
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 07:31:29.3462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xY6crsu0BASa/3o7ho7EovCSKqr1NFWPliGzwiI194gm5wOLiLKmr2Vt3UQG+CwhLkyjwucTel6qdKd1wt+OuFv9HdALx6E1ZURTa0j8feI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5409
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jun 2024 07:31:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16229

--_000_TYWPR01MB1186229B58F2B4E702B4688E7B7C22TYWPR01MB11862jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello,

Sometimes the internet is slow in some of the labs.
The only real mitigation we can have is to increase the appropriate timeout=
s.

I had a quick look at using LAVA to automatically retry<https://lava.ciplat=
form.org/static/docs/v2/actions-repeats.html#retry-on-failure> upon deploy =
failures, however this only seems to work for failed downloads, not very sl=
ow ones.
The timeouts still fail the job when hit.

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
Sent: Friday, June 14, 2024 4:49 AM
To: Chris Paterson <Chris.Paterson2@renesas.com>; jan.kiszka@siemens.com
Cc: dinesh.kumar@toshiba-tsip.com; cip-dev@lists.cip-project.org
Subject: Artifact download failed due to timeout in 'lab-cip-cybertrust`

Hi Chris,

Hope you are doing well.

Yesterday I noticed that jobs which run on =1B$B!F=1B(Bqemu-03` device in `=
lab-cip-cybertrust` are failing due to a common issue i.e timeout during do=
wnloading the .wic artifact.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7094898973#L69=
9
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7094898970#L98=
5
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7094898965#L67=
0

Do you have any idea about this Infrastructure error ?

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

--_000_TYWPR01MB1186229B58F2B4E702B4688E7B7C22TYWPR01MB11862jp_
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
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
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
<body lang=3D"EN-GB" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0;mso-fareast-language:EN-US">Hello,<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0;mso-fareast-language:EN-US">Sometimes the internet is s=
low in some of the labs.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0;mso-fareast-language:EN-US">The only real mitigation we=
 can have is to increase the appropriate timeouts.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0;mso-fareast-language:EN-US">I had a quick look at using=
 LAVA to
<a href=3D"https://lava.ciplatform.org/static/docs/v2/actions-repeats.html#=
retry-on-failure">
automatically retry</a> upon deploy failures, however this only seems to wo=
rk for failed downloads, not very slow ones.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0;mso-fareast-language:EN-US">The timeouts still fail the=
 job when hit.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p=
>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-ligatures:none;mso-=
fareast-language:EN-GB">Kind regards, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p=
>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;mso-ligatures:none">From:</span></b><span lang=3D"E=
N-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:non=
e"> Sai.Sathujoda@toshiba-tsip.com &lt;Sai.Sathujoda@toshiba-tsip.com&gt;
<br>
<b>Sent:</b> Friday, June 14, 2024 4:49 AM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;; jan.kiszka@s=
iemens.com<br>
<b>Cc:</b> dinesh.kumar@toshiba-tsip.com; cip-dev@lists.cip-project.org<br>
<b>Subject:</b> Artifact download failed due to timeout in 'lab-cip-cybertr=
ust`<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hope you are doing well.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Yesterday I noticed that jobs w=
hich run on =1B$B!F=1B(Bqemu-03` device in `lab-cip-cybertrust` are failing=
 due to a common issue i.e timeout during downloading the .wic artifact.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><a href=3D"https://gitlab.com/c=
ip-project/cip-core/isar-cip-core/-/jobs/7094898973#L699">https://gitlab.co=
m/cip-project/cip-core/isar-cip-core/-/jobs/7094898973#L699</a><o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><a href=3D"https://gitlab.com/c=
ip-project/cip-core/isar-cip-core/-/jobs/7094898970#L985">https://gitlab.co=
m/cip-project/cip-core/isar-cip-core/-/jobs/7094898970#L985</a><o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><a href=3D"https://gitlab.com/c=
ip-project/cip-core/isar-cip-core/-/jobs/7094898965#L670">https://gitlab.co=
m/cip-project/cip-core/isar-cip-core/-/jobs/7094898965#L670</a><o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Do you have any idea about this=
 Infrastructure error ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks and regards,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Sai Ashrith Sathujoda (T S I P)=
<o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_TYWPR01MB1186229B58F2B4E702B4688E7B7C22TYWPR01MB11862jp_--

