Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B633ED41D58
	for <webhook@archiver.kernel.org>; Tue, 12 Nov 2024 06:18:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.80552.1731392333262395033
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Nov 2024 22:18:54 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4AC6IoFZ2098934; Tue, 12 Nov 2024 15:18:51 +0900
X-Iguazu-Qid: 2rWgZF6BV1IlKr4f7z
X-Iguazu-QSIG: v=2; s=0; t=1731392330; q=2rWgZF6BV1IlKr4f7z; m=cCLkPpvq5JnwiMAs8LCctDuEPq5sILQcKamUdUbBFuU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 4AC6Imu51239010
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 15:18:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddXeboCiKU97/bd68IJ3fFTYXmSSnQ5lqs++z1pFD7ooxI7UA4SWxMsILwZgYdfsxNxP33ktJZXxwQerW+vX87LBhyevpq5qIuJmOkgWpCy1kHrBxykr8jQmWjQMTgyDA6DkTHwyTr9/vcpdb5XooY218BX2JwxfG/q9cEEh/1yWIxG0gxwBD3T3y35GdP8oUhaEKJXgMzIYc8ARfnguHI0vizDhzlcnrku2y4ioyN0swfJfdPsUiVE6UXv81PZgvxDkKAFB8vQwwdi1CuJubzEmE26Bw2H4F/+sNpmQJPFAPtxCw4DOx2CNt+d06lmqhEGGkbNXOi8MFI41h2Q4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1PpMmgYmFgNXTBdWCVe4g0yCtt89H0JMpXeL0bFEXM=;
 b=tw8RgnkXHn22rE60FAkKvjx6zURpYBkAHLAq5kBLxXmHxrMcM2FsySqSQplUMjLJj5cWqzCEyh+JXoOF/XCxbqpigMcmQjt+RsTmugoZrvny5O9Oee+g1BegKy/J9tSsQC/ywSBaZ1VnMXWJFS7dwpB3A2UVDmzWWAwY2BwU8Y7ipD05eJJmxwdGqoybnqMsItoF9B6wLA8DfHlR5/lSCQoJyexcEnblv/lPc2h9MngMb0NII3rVmaDWwG0Wbz6vSimc9pjDidimGzfqYshmdxD+rLdcFoXYQ+a9qCDzcRz1ycQt0U0zn+lX6rVc8Va6VDNhxDmz+75vqa13ClgeeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <dinesh.kumar@toshiba-tsip.com>,
        <cip-dev@lists.cip-project.org>, <cip-security@lists.cip-project.org>,
        <Chris.Paterson2@renesas.com>
Subject: Re: [cip-dev] [cip-security] Manually run Kernel and IEC tests on
 M-COM x86 and generate results
Thread-Topic: [cip-dev] [cip-security] Manually run Kernel and IEC tests on
 M-COM x86 and generate results
Thread-Index: AQHbNLcv3vC8deZB0Ua07zkQ6b5nXrKzKmEAgAAAV+k=
Date: Tue, 12 Nov 2024 06:18:46 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61035F246D6307C5F03F2421C2592@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AC4F03F328776A6DFBCBC2592@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <59bd0258-8092-4988-80db-e8f5a14a5104@siemens.com>
In-Reply-To: <59bd0258-8092-4988-80db-e8f5a14a5104@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYYPR01MB7072:EE_
x-ms-office365-filtering-correlation-id: 797f649a-2e10-4609-d60c-08dd02e1ddb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?NTBxSGtIYllHWG1aUVhrRjlmL2xDemkzKzJpMDdiZXk3b0UwQmxDbUl5?=
 =?iso-2022-jp?B?RkUzbEdKMlp2amdrSEF5VkEwcTBueVBxUEc0OVVGOXFobXRBNC93NGk5?=
 =?iso-2022-jp?B?TTNtR1lNRWtONGtZSmNzNXd2Zm4zR1duWE1abXFHRTlXVkpkNCtMUW5t?=
 =?iso-2022-jp?B?WFlDVDFSbW40ZXdjblVDQ01BOTQ5YUlGcmk5dlhXOERjLzk5bWROdmto?=
 =?iso-2022-jp?B?S2Z0aVZSeDRxdFBNMENKRG8vU2J4KzEyMG10dmNxMW1rMFFsMFprektT?=
 =?iso-2022-jp?B?ZGk5bjFXci9WcGZoMW1Fd2R2Z1psWTNiM0F4WVdPKzI2NVdkNTlpWGhR?=
 =?iso-2022-jp?B?L0Y0YU15ZmVFMHZyR0lhRk5PYkZzRFNYTXVpTkw0dXNkbUpKYlFuTFRm?=
 =?iso-2022-jp?B?Skcyc3h3bmNqZ09uSTVYWE93YzUybjNyTk9aYjk0N3N6QVp3cDRkbVlH?=
 =?iso-2022-jp?B?Sm5ZYUwrSUc1Sno3QTJWQ2k4ZXAvcGo4blArMFluUFZ5SkRBeFJnUnRh?=
 =?iso-2022-jp?B?eXU1dVJiTzNNWGRBZzNHdFpRN0pqVXJWYkNVTDg5K3YvSnlmVkRaYmpJ?=
 =?iso-2022-jp?B?a0lNNWYyd1dIZFJZczB0bDF1VVd5Kzk4QTlMNStDM01JdlJJR1k5eGlt?=
 =?iso-2022-jp?B?UGNCTnkrSUVKK1FsRnpWUXNlSE1ZL2c4cGpLZE1ZV0hHcGV6RWpJQlda?=
 =?iso-2022-jp?B?Rlh2SFN2RWhxOTZNaUY2eVZBSGkzRUJuVDZPcHNFSmNwcjZkTDIvR3J1?=
 =?iso-2022-jp?B?eTg1WnRwamhrVG8rRHNwUTRUVkRZTXlocFhrUmR2a1pKNkhlUmNhK0hR?=
 =?iso-2022-jp?B?cFFtWG5BSXFlQTN1dmlQeHZyMnovVGk1Wm9hdHFtenJudjFuU2NLdEtO?=
 =?iso-2022-jp?B?ZWpUZ1JQRjJBYVdSZmg4clZ3U0UzT0R3SDAvT09YYzZsWmplMTE4TXVD?=
 =?iso-2022-jp?B?L1BiUDZHOTE0Q3FFWDZMWm5NRHFINnllc21jZ3pRc1E0bjZ0MlRCejNI?=
 =?iso-2022-jp?B?eVFULzZvbms1UldwVVpWYnJOZW52S08wUzlvd1NRSlpHSUNkMm1Ddlpa?=
 =?iso-2022-jp?B?TzR5R3J2U202R0JkY21IMEhTVUJBQzUrdVErL2E5N2ZsZmw0ekdvNDFo?=
 =?iso-2022-jp?B?cFAxTUJhb2VzQkxucUIzNS9XVFVEampOa2d1VTlWblZxb3dsSElXM1R2?=
 =?iso-2022-jp?B?bnhjNzVSc1NUays0ekhML2ZGajI1RTJybWZDMXo5cDBXaHY5NlAyOTNi?=
 =?iso-2022-jp?B?MEo0WGNUNFlaaVpBNlIxdXU1UFJwNmFKZ2xWekNsTjJiSjRvSEwybVJn?=
 =?iso-2022-jp?B?ZEJObnZYNW1renJCa0RhMWoxS2o1Qy9ETHZUSEp5dDBIdXczRmF4YmZB?=
 =?iso-2022-jp?B?cUJZaTRxMlZEbzVuc1JPQkVLSWNvMXQ3aVdkUGVVMU1iWG9GY0hEUjZC?=
 =?iso-2022-jp?B?Z0dFdlZjUTZLcVRzaS9xblJUNEZhYlFMeWNBUURhQWFyY2FUY1dlTkdJ?=
 =?iso-2022-jp?B?TzB6cXVNR0p6RUZjNFZ2T1llczhlMGEzaUdoNkJDRThBb0VPZnFjRXE0?=
 =?iso-2022-jp?B?K25Tb1B5Z3dRWlh4eTF3VnlkbklTNXYwQ3MyTW9JWDBscU0xVkdPWTI5?=
 =?iso-2022-jp?B?SUJ3Z1hKR205NXBsd21oSDFLV3k5MXJucmpjNTJpOUMzdTE1ME9XQVlJ?=
 =?iso-2022-jp?B?RDIyT1VZNVJMZzJYNVBVa0hOcHNwQkM5MUhjdFhzMXRKRkg3U005Y0Nm?=
 =?iso-2022-jp?B?SkczNDZqdHl0Znd1Rm1VaU5mb2ZmY3ROWTZyNjlHeFdubmswdmFSNmZh?=
 =?iso-2022-jp?B?dVpHMmNtVkZSclNuNUdQb0NOWlM5REJoK21NRkNKbCtMcnpGVjNwSXpE?=
 =?iso-2022-jp?B?TjRLT0JiY3ZMWUpuNjM5c01ZZDNkdzVJclhOVy81VUgvNXpTU0ZlWGp5?=
 =?iso-2022-jp?B?b2lxRGI2ekQ2d2FEeXdNM0tzM1JtZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SDdiN0RtUWQrOWJNd010R0VGRGpKVW55OGhkSEFNNVFJYlJzNmNrZE5G?=
 =?iso-2022-jp?B?UUorRzN2ZExTSml2ZTJJbGl6KzJ1TjZOQ012Z2JPU25QTU5nbHJCK3VW?=
 =?iso-2022-jp?B?Tmw1NXVYN1I1RUd2OVpQdTdRYXVDT0srelR5VWRoNzNqREpDK01NSnFD?=
 =?iso-2022-jp?B?cEZYQmpERFVwMWUvV3cvdUVFK0pRRU1Pd0J5ZjI0cFc5N0JZem5LN3hl?=
 =?iso-2022-jp?B?SDZHOElkL0xNb2dsVjFoYzFxajRidGdlT1NCaXlrUkNKR1ZtRG9RY3py?=
 =?iso-2022-jp?B?dXQ1eVNJYU54K3JTRmEyUFR0YWdhcjRjZktkS0pXYXIzSGxLUFM4K3BO?=
 =?iso-2022-jp?B?a2hpa1dQOXNKMWZjcHFoUk83cnlOOFo3RkRkOElmdHZqZ0M0MlN4MVJK?=
 =?iso-2022-jp?B?ZjE0R0xvRHdPNHM3UjRSQithUWIzcmlrVXBvTFN2S2daT1RiWS85NHB2?=
 =?iso-2022-jp?B?VWZuaENPRmFsSWIzd0hKNWtnTHNrOEdvS1RzSkhKcnZLMzBOMkZVYy9Z?=
 =?iso-2022-jp?B?RjBLWm1yVmhxSThzY0hhZUVUY0szdnk3alBERUgzMVJKMlhVOXc2TXV1?=
 =?iso-2022-jp?B?VmRJQmtBRnk5dllwdjFLVUV4RUovV25WeDQvVk42cm1SMWlMMmc2SGxn?=
 =?iso-2022-jp?B?dkxnc2phaFBuaXVoVCtDdGw2VFBJU1AzSEsrWFE0TjdMNjZsZkpJYjY3?=
 =?iso-2022-jp?B?cm5yMUhFemhLcFJyUzZuTGhkeWZtb1N1WDdHTnM2blF6R2krZzNVVGY1?=
 =?iso-2022-jp?B?amFKY3E0WS9rRGJHcHlDLzlvdTk0RU55NGo5dFNaVTRGclBIWEd0KzVZ?=
 =?iso-2022-jp?B?eG03SkxmVFFRVm14bUJFWWs4ODFuRjdmZCtJSjIzMVFCb3BDdkdmTDN5?=
 =?iso-2022-jp?B?ZzhmcWRlNTlTUEFSVmRnZi9JZTdnenZlRzNvMUM4YVpTeVJNU3ptOVVv?=
 =?iso-2022-jp?B?U2oxMnoyYk5zY09HWnI5SjMzTGpUdXFRMGZ4M1F5NGlDVkUraDR5WUlm?=
 =?iso-2022-jp?B?ZG5GTWx3U0VJWW5FM0RFZHQxT2cwbjVHbndSdysxWitIUnFQR2wvM3A4?=
 =?iso-2022-jp?B?aUxsN3Z5YmNzL2lGQWFVUzlTQVdVMmEzaEpYbW45MVVaRXA4eGxrdW41?=
 =?iso-2022-jp?B?ZDZOREtUTUxrdXErdTVleVFLZ2NmK1R1RWxiRFl2Y2t1WkRZODlBaENn?=
 =?iso-2022-jp?B?clNidmpOaFh0OXFva2l1YzF0OXlXUVZkVDBCdmQ1OFNPRHdMMlNFcnQ1?=
 =?iso-2022-jp?B?bGd1ZGVMQ1I4blRjMGt6VkVMTnZXVzVMOEFzNWh0Z1FXY25uVHNPMzZR?=
 =?iso-2022-jp?B?ODljdmlmaUpWYmxPTlZNSnVMLzUxYkU2ZUY4czNURzhId05vS2J6c200?=
 =?iso-2022-jp?B?WjMrczlLSlZTWGVXL0FVYTZWK2lGOTI4bEFPTzA3U3ZmYy9KY3pYU1NF?=
 =?iso-2022-jp?B?Z2h5SGJBSm5KRHMvM3VWTlo3dHc4bDMvOElWWWliSjRET0pYVDhUK3Mx?=
 =?iso-2022-jp?B?NzRpelJJZUErc3U1TDdBODNIYmZMUUNPcFhHbXppamJpSlpZNjN2SThG?=
 =?iso-2022-jp?B?b0MwR0pUL0dPdFFqWk95TnJVVWlJK1NUcXJBK1BGdUxzSG96bTVlVXNn?=
 =?iso-2022-jp?B?V1NPZFZ4NjN1Y3RyVVV3eGZnc010YzRUaEUrZkRsZEdmWEFZUksyd2g2?=
 =?iso-2022-jp?B?RFlMelVleXdZOFMvSkNZYSt4M1NheHU4dCtPREt2NFVXUkpxTDlreHdP?=
 =?iso-2022-jp?B?ZkRDczlHRmJZbXYxdTlWaC91YUs4dVJkOWJkWDJTeDZEZExhQW85bXpq?=
 =?iso-2022-jp?B?MC9kUmNVQ3REQ1FBN2oxL2RWRHE0WFdwaEQyNS9lL2RpVncvQVhBMjRK?=
 =?iso-2022-jp?B?cGd3dUFaZktFck1LNWt5cFF6MExKTWpsYzU2V1lsRzlVSm9DOU41VGs3?=
 =?iso-2022-jp?B?NkgySDJTUHZYbEtiNXNxUURvWjlxNjIvQlEzM1RDVUJqSlROaWhzZ2l4?=
 =?iso-2022-jp?B?STVraS9wd3ZwOFo4TFdoZStnZ3ltZEwzQStQRmZra284dzVtS2ptMmZU?=
 =?iso-2022-jp?B?MjNCSGtaMEE3elBNak1GNk9zVFNrYVcwL3lEUnpGM3h4WWN0Ym9XV3Zj?=
 =?iso-2022-jp?B?Ym5lcDJXeWxoWTlpRmQ4VGRaRE90ZDBHRTdDZ1FJdVg3NGtETFdyMXZi?=
 =?iso-2022-jp?B?ZllORUtEQW82c2dxMzhuT0lFT3l4MitJNmtMU3BwODg1ekdWVG5XYmMx?=
 =?iso-2022-jp?B?RG1NTHQ5c0Y1Y1ovSEtZNHpnbFZZQlRiUzFhQnpoKzhnM3lValRrNktO?=
 =?iso-2022-jp?B?MHZrL2FLYnRhYTFZYkFWWjdIMVJ5azRNM3c9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB61035F246D6307C5F03F2421C2592OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797f649a-2e10-4609-d60c-08dd02e1ddb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 06:18:46.6662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ykW6IVQ5ZBXN0RCrpxT6eQqFftMZaaHiQPo2KF8zl8SZvslVVb4Z3g6O8ZKJzkM6umZs5yzAidk7ndjJNAeBb3HzXiMk4v9eEvA5YhYFDVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7072
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Nov 2024 06:18:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17239

--_000_OS3PR01MB61035F246D6307C5F03F2421C2592OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Jan,

Sorry I did not notice. Thank you so much.

Regards,
Sai Ashrith

________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Jan Kiszka via lists.cip-project.org <jan.kiszka=3Dsiemens.com@lists.=
cip-project.org>
Sent: Tuesday, November 12, 2024 11:42 AM
To: cip-security@lists.cip-project.org <cip-security@lists.cip-project.org>=
; Chris.Paterson2@renesas.com <Chris.Paterson2@renesas.com>
Cc: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>; hayashi =
kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S=
!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; dinesh kumar(=1B$B#T#S#I#=
P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.com>
Subject: Re: [cip-dev] [cip-security] Manually run Kernel and IEC tests on =
M-COM x86 and generate results

On 12.11.24 05:14, sai ashrith sathujoda via lists.cip-project.org wrote:
Hello Chris,

Hope you are doing well.

Regarding IEC 62443-4-2 certification, the certification body has asked for=
 Kernel and IEC test results on M-COM device. Based on my current knowldege=
, I believe that the test suites mentioned here https://gitlab.com/cip-proj=
ect/cip-testing/linux-cip-ci/-/blob/master/submit_tests.sh?ref_type=3Dheads=
#L55 shall run for every updated kernel image on different CIP reference ha=
rdware in LAVA.

Since availability of M-COM device on CIP LAVA Lab still needs some time, w=
e are manually running each test suite i.e SMC, Smoke, LTP etc. from https:=
//github.com/kernelci/test-definitions

https://lava.ciplatform.org/scheduler/device/mcom

Jan


There are no issues with running SMC, Smoke tests but while running LTP tes=
ts it is trying to install some dependency packages to the root file system=
. Currently it shows it is a network issue but even if it gets resolved, th=
e packages cannot be installed because the security image has read-only roo=
t file system.

Another idea which needs to be discussed is, since Kernel tests by name mea=
ns focusing on testing only the Kernel, we can try to use a different root =
file system to run these tests. But this is just an idea, this needs to int=
ernally be discussed within SWG and with Certification body.

I request you to provide any suggestions regarding the attached LTP issues.

Thanks and regards,
Sai Ashrith (T S I P)


--_000_OS3PR01MB61035F246D6307C5F03F2421C2592OS3PR01MB6103jpnp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hello Jan,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sorry I did not notice. Thank you so much.&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of Jan Kiszka via =
lists.cip-project.org &lt;jan.kiszka=3Dsiemens.com@lists.cip-project.org&gt=
;<br>
<b>Sent:</b> Tuesday, November 12, 2024 11:42 AM<br>
<b>To:</b> cip-security@lists.cip-project.org &lt;cip-security@lists.cip-pr=
oject.org&gt;; Chris.Paterson2@renesas.com &lt;Chris.Paterson2@renesas.com&=
gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#=
D#I#G""#M#P#S!{#M#P#4=1B(B) &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; dinesh=
 kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) &lt;dinesh.kumar@toshiba-tsip.=
com&gt;<br>
<b>Subject:</b> Re: [cip-dev] [cip-security] Manually run Kernel and IEC te=
sts on M-COM x86 and generate results</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"x_moz-cite-prefix">On 12.11.24 05:14, sai ashrith sathujoda v=
ia lists.cip-project.org wrote:<br>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Hello Chris,</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Hope you are doing&nbsp;well.</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Regarding IEC 62443-4-2 certification, the certification body has asked for=
 Kernel and IEC test results on M-COM device. Based on my current knowldege=
, I believe that the test suites mentioned here
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/blob/m=
aster/submit_tests.sh?ref_type=3Dheads#L55" data-auth=3D"NotApplicable" id=
=3D"LPlnk500022" class=3D"x_moz-txt-link-freetext">
https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/blob/master/submi=
t_tests.sh?ref_type=3Dheads#L55</a>&nbsp;shall run for every updated kernel=
 image on different CIP reference hardware in LAVA.</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Since availability of M-COM device on CIP LAVA Lab still needs some time, w=
e are manually running each test suite i.e SMC, Smoke, LTP etc. from
<a href=3D"https://github.com/kernelci/test-definitions" data-auth=3D"NotAp=
plicable" id=3D"LPlnk743732" class=3D"x_moz-txt-link-freetext">
https://github.com/kernelci/test-definitions</a></div>
</blockquote>
<br>
<a href=3D"https://lava.ciplatform.org/scheduler/device/mcom" data-auth=3D"=
NotApplicable" class=3D"x_moz-txt-link-freetext">https://lava.ciplatform.or=
g/scheduler/device/mcom</a><br>
<br>
Jan<br>
<br>
<blockquote type=3D"cite">
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
There are no issues with running SMC, Smoke tests but while running LTP tes=
ts it is trying to install some dependency packages to the root file system=
. Currently it shows it is a network issue but even if it gets resolved, th=
e packages cannot be installed because
 the security image has read-only root file system.</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Another idea which needs to be discussed is, since Kernel tests by name mea=
ns focusing on testing only the Kernel, we can try to use a different root =
file system to run these tests. But this is just an idea, this needs to int=
ernally be discussed within SWG
 and with Certification body.</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
I request you to provide any suggestions regarding the attached LTP issues.=
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Thanks and regards,</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Sai Ashrith (T S I P)</div>
</blockquote>
<br>
</div>
</body>
</html>

--_000_OS3PR01MB61035F246D6307C5F03F2421C2592OS3PR01MB6103jpnp_--


