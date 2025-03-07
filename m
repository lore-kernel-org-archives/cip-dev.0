Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D62FC19F32
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 09:56:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.7833.1741341397854797021
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Mar 2025 01:56:39 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5279uZOn1127366; Fri, 7 Mar 2025 18:56:35 +0900
X-Iguazu-Qid: 2rWh5b6vFJWsPJJdtU
X-Iguazu-QSIG: v=2; s=0; t=1741341394; q=2rWh5b6vFJWsPJJdtU; m=9PGqn/HzthhJ/bbHelovgoOpkjcb7xwUL6AzTIZpzps=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 5279uXhU720423
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 7 Mar 2025 18:56:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gmxq3fNqn3YtpXJ0u2zTvWTwkBIAjd38WdUf1AdxuV6v913qHkQLBy6+cu+1ojQUC1924h30QbwXf5e7aIFIM58hra5x8agfi8iLGnOj81yKX6LrggC4E5MoDwXfhCMGt1WnD8XO6vo8PkEuWS00a8+s7LsFTYFH7hXc8R8lhR1asOgXc+2k5kmC0DMvSPwqkz5b18+whVgDNXluGrkQXZhMDSRknqbWdhugdjpnp8+kFWFiBj/1kHOfJHmumhP8p5WoZOtRTdfWAmWS1ZctwEmd4hVBKca0iDhiUQrxCiEfKgVa8kjkJH/gFvLInjzWnw4ZbXRn8TiUQPJavsRxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNufpClppzQUguKOP7mKbWWdCy5T94g6M1pQ3+rXBis=;
 b=C/BXL9/BxZRxLV9x9iGfN0aYYZQL66ycwiM51K/brgdW/HpnKeztMmmyOUIhX1I0t09F8TJ5KV8XS1KoSBtIp7bjMJH6zjoH2d+xqei5o7K369mZAGytr1Q9IPm+wglryVS8sljw/QnE1aEknPq6xsr/btFWsKFhPLqZBOZjazYPMLkU+bq5TPVPbXhBpHNBlz70FISs7DuwSGTijkipTSbWaEothdVXgbPEbkadJLGI52SYZF1dzxO7Eq5evoZIb3M8Uu6mXovapbTwtBKK5rJ1Kfygpz9rELdDKcqUzk3zMPfnKVundynrkWS7cHIGFjfCZn7BOl+lpOY3raCZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
Subject: RE: Add trixie OVMF keys for testing 
Thread-Topic: Add trixie OVMF keys for testing 
Thread-Index: AduPKv1Bhwt2OQq0QKq4V/WtZyorngADrqDwAALYFsA=
Date: Fri, 7 Mar 2025 09:56:30 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB1107527CC89D021A74A759922C7D52@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: 
 <TY3PR01MB1107521441FF10362116BA904C7D52@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <OS3PR01MB5896B41E4172736E3AFCE042B7D52@OS3PR01MB5896.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB5896B41E4172736E3AFCE042B7D52@OS3PR01MB5896.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OSOPR01MB12347:EE_
x-ms-office365-filtering-correlation-id: dd93d0e1-2dca-4af7-c43a-08dd5d5e55e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WWFpOC9RQkNlODBGZmlyRlZ2OVVrN0ZIUDl2L25wVEZvZ08wMm9XMXV4?=
 =?iso-2022-jp?B?bmJ4ZmpwZ3hubTJ4S2h4WlhHMHlJRmtYdmQzLzZmbTNuZ1kxcjNOWDEv?=
 =?iso-2022-jp?B?MWZLb1JPWW1adWFyZmFpaTRpaGtzT0RlSTRxL3JFbVY3VDNJZmtQL1NL?=
 =?iso-2022-jp?B?cm5mOXV4aVdteEVraGtNbUFDRHo0U2RZQkQ0ZWxFMXpyeVlhVkJGaW1T?=
 =?iso-2022-jp?B?aS9FTWh2eGxZOTJqa3c2bGlFdmc4aXJPSmJpYTZsbkNaU3hLWE5oMzk5?=
 =?iso-2022-jp?B?eFE1Z3Z4RDZMd05YaUowczlYM0FtNTUrSzlZKzdRNmxDRU9uK1dXMjlT?=
 =?iso-2022-jp?B?WFFVcXp2QXg4RWtJS1B3VUsyQU9DSUNiZjBMbENCTkJoY3Q0TXR5Zk80?=
 =?iso-2022-jp?B?UE9PQnpEK3hjT0Fkck9ZS0xpR05jcVowcDEvdnBDUVZmemp6OGV3UmNW?=
 =?iso-2022-jp?B?c0R6U0hpSEppTGp6RThGWVF3Wk5PU0RXSDNkeVNETlJ1Nk8xQXV2M3ds?=
 =?iso-2022-jp?B?eGxucWQrZ3c4ZnFidk83WFVkemZ5MHV2bmoxbmZIajdMeEJTamtqZ0Nt?=
 =?iso-2022-jp?B?RHdLT0E3elRyNE8xOGw5UE1ma2hhb0hDWlNxdHpVdnJBQlpyeUVSdnYz?=
 =?iso-2022-jp?B?eTJIbDI1K0l5NnpjOXlMS0oxVUUwckFQN3JqdWxjS21RMkxadkFQdy9C?=
 =?iso-2022-jp?B?b3ovdTIzckZ0a21JZG40RnRlMW1lek0yZ1F3b1ZhRHZ1WmNva1RjNkhi?=
 =?iso-2022-jp?B?SlRjbGpXc2cvYkh2QTBEa2hwMnZzVDZWeS90Rm9IQmxabU9xWEh5dTNJ?=
 =?iso-2022-jp?B?aFBvV3pKM2xIbTJJdlBualR1Z3pzd1hyYyswKytVVzdtVHVMc0I4RnM2?=
 =?iso-2022-jp?B?SGNLRU1rMmZaazdYS2hPRUQyU3d2azlWVGI2cVdrRXk0SkhRU0xMZ0dT?=
 =?iso-2022-jp?B?MUhXVnphSXlOajBvWUl2dGlTck96SEx0d1V3dXNKQ3JJbzBsa3dtc0Mv?=
 =?iso-2022-jp?B?VGN0dFJNSFQ2RzBSY0U2bzFpOEVCUWlJc3FvVmZIRTBMdUdGMHhZVXBE?=
 =?iso-2022-jp?B?akF5OUJXTkgrQW1ydG1HV2cxNjh0Y2U4SUZ1OVZwNXRHaHM2QXRoV3ND?=
 =?iso-2022-jp?B?anppQTVVbXJ0L2g1bkp6TXhscW0yYlArdmpsaklBUXpaeHg3enNQN08w?=
 =?iso-2022-jp?B?RmZicTMwRlJyS1hnVTkxYU92aUNFU0xpWTlBdFpwZkVCa3Z1c3oyMkhP?=
 =?iso-2022-jp?B?dnlseDVqeWoxOEQ3R1V4UER5R2RjMWQ1QkZLaGZGT1J5ayt4RUZ3VHNQ?=
 =?iso-2022-jp?B?MVREZTJycWljc0xxdFMwdGgxWXJmYmVrdkZDbVByaURpc1NHMlZqUWcr?=
 =?iso-2022-jp?B?a2wrcldmdG9UYUtjTEtjNzJLakhyQjVZTS83Yno2anFGcGIrUDF1dkVF?=
 =?iso-2022-jp?B?UEh4QW9oTUpHME9PaTA2SlVTaklrbVppM002cHlyNTh1WFd6S0lMOUN2?=
 =?iso-2022-jp?B?Umc0NGFCT1ZIa29ZTXpLRFVadmlQWkFVbC9jQS9BdEhKeDlkYzZiemN5?=
 =?iso-2022-jp?B?b1FOVTFoSFh5S1ZzWTA0SURJYzl6L1dla0xRQkN2N0Z6U0tXY2Q2NDc1?=
 =?iso-2022-jp?B?QUQ3MWZ5R3JCSVNLUHJYSmlkbERDUkkwb2p6MFV2Y2ErUERMaldwQk8v?=
 =?iso-2022-jp?B?azNQd25wYy84ZHVwVzF4dGI1d3hRa25zbnZscDA5Rys1cEQ4NHhuQ2VZ?=
 =?iso-2022-jp?B?L1licDVjajc3eHJSOHIydVpnZDdZMFNwMXRtaDRJbGlFWmJJTWhOWkQ5?=
 =?iso-2022-jp?B?M2M2ZkRjNUFjQS9WZEFadWhwaGdCNUpBSmZDWEJkRkZKRTA2TnQ5SHpI?=
 =?iso-2022-jp?B?dW9Cd0xUSEMvRFBjRmNSU2lGNittaVRBWWVsQ1ZKVngyd1VkSDJTZUNl?=
 =?iso-2022-jp?B?eWZYRHRKYUNZV2hsUWdNc2JaOFdZVTZtK3ZELzg0WlhFL1hyUWd4blNE?=
 =?iso-2022-jp?B?UFdhVEUxTHJiMDJmV1F1OEI3bU9hbGp2b3NZT2o3TzFrNHphRzJDWG8w?=
 =?iso-2022-jp?B?SWc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QTlNUFRpQ0tTZU55N2hqcHZHTkRKOHpJU3A4M0NtQ2VnMzFFQzNaSkox?=
 =?iso-2022-jp?B?eEhnVmkvdHRaS1FMdWs0V3QxQkhHV2dMQkpSZ01wSEU0aXVQUm1acDJz?=
 =?iso-2022-jp?B?NzlIZnBJemg0ZGVQVmFFaG9CekJKQlZuNVExd04zT1FtYTV6SmlwKzBR?=
 =?iso-2022-jp?B?VzNOSWJBR2ljZEtuMURoeitzMUcwNHZRTlBTMGtFMzJvTUZUdE1PUFBi?=
 =?iso-2022-jp?B?azd0aTl3NmJGb2pFdzViOFd5VjZKQ1I3MDN3STM4bWJVVG43NFA4VG56?=
 =?iso-2022-jp?B?QzV2WnJ5WC9QUWJWSDNVWGJ0NGFsTWorUTJhRXZpenFLTFc5cE9WNWpj?=
 =?iso-2022-jp?B?YStDR2c5Vk56aWNwb2IxRDdYbitkUGwrS04waGhGQnkxcy9QY1hNa3Rx?=
 =?iso-2022-jp?B?UkRxbzFTclNHTXdLOWpnN3Jva0N3UmdwU1IxRGc2ZUdZMkoxQ3pyNW1y?=
 =?iso-2022-jp?B?alhPTjRxS3RTR09SWFZLd2dwbW5FcjhleXYyMjAzV1k1NmhwR3JHSUhw?=
 =?iso-2022-jp?B?RGRsc0hRek16K0lRYTh0TDgzem5nOGZ6d3IzSlEvQ2Y4WVRIeFg3MzJj?=
 =?iso-2022-jp?B?b1N3K0lhZWJUNWpPVVo5dHBwNXYxQmtjZDR1aE9NaytmRWFlR1AwaTFw?=
 =?iso-2022-jp?B?OVVSc0x5ZmVaTFNVbUV4QnBqMkFpaXNOc0Z0VndOTjBWclNJZExWTkxm?=
 =?iso-2022-jp?B?TXE4bjJsSlFOa09JS2hYbEpGT2RNWVZjNUdYNFNKNGg0OS9DT0tCOE1n?=
 =?iso-2022-jp?B?cTd0UHd4YWFRR0ZtdEZJd1o5SmNxUkJjUXR3Q2hIcmZveUhSOEdCY3VQ?=
 =?iso-2022-jp?B?NTRITTVsbHVnME9Gd2xEZ0x1eENRV25IZ1cxYVRpOCtWV2ZBSmNVTHpL?=
 =?iso-2022-jp?B?R1hYLzg5SithVExBN3J2NzlOZitRQUZGNTJHbi9UdVM5aXQwOUI5MU5L?=
 =?iso-2022-jp?B?bCtrUUlOTVRZNERRV2pUdThra3Q4Y3Q1eDJaa0VrV0w2bDV3UFA3bk5J?=
 =?iso-2022-jp?B?MER1YXdkME5UNXlxYTBoNDlrT3lIQ2pvVTZXTlVaa0dBaWZxRml2c2JB?=
 =?iso-2022-jp?B?M3Z1SEY5bDhzWFloR0UwZ0ZoL09vcHU0RUN4Tzh4M3dxNGZBZWdBL2Q0?=
 =?iso-2022-jp?B?MWJEOUlLSzFvaERBcEZLdGRZM2d2RXFvNFpmQVdPNG90bW9uOENXQ2x0?=
 =?iso-2022-jp?B?SEs3c0h4dm9ZZUdhRVpsdURld1l1NllqRkhvd1JMYjF5UFBmWW05SzUv?=
 =?iso-2022-jp?B?UmdoRDgzV2d2aGIxZk15cCtXcE9PcWxQakpBZ2RCTk9TVnVJTXJaRlls?=
 =?iso-2022-jp?B?dndDWDJtdkVJVjhLK2xhcGJZU2xITDJwaVNRTzh5cDR1MXpuSmVpc1kx?=
 =?iso-2022-jp?B?MnZwck1IYytGSXVVVmlORGZLMEpjc1VnZFdyQ0NocTArbk1wM09FU2Rp?=
 =?iso-2022-jp?B?aEJzVDZVdGNNY0F1NS9OZUJhWlljUjU3dzRqTG5lUEpJbi9GTWpHa1pl?=
 =?iso-2022-jp?B?WXBuTnVDY2lRSzczM0dqeDVBQjg1WmJ1YmRhdFZwaFN4b21MRVFoZXlo?=
 =?iso-2022-jp?B?U0hjd2I1RmRQNVVoWXlPWjUzbTI5YzlaVURpNnN3UExKTjZYNkU2UG50?=
 =?iso-2022-jp?B?bW9mVlFwQ2g4VU1LVzk5ZUZlbmFxcmdOMVQ3RzNXM1BsbGhRZHVlQXhv?=
 =?iso-2022-jp?B?a0hzZk1EZGJ3aStlZTdld2FxU3lOMWhPNWlVR2NCeWp6WXVLZ1RFSXZE?=
 =?iso-2022-jp?B?WWhJZDdwcHNyckJXRHJpRmNrN09JZmxoZ2VKRkdlZHlLbWNtWk1ZekZs?=
 =?iso-2022-jp?B?TkljUUZKL2MzVDFvRkRORzFXT1Z2TC9iMGpLWVpKck15S25pbzFkQ0M5?=
 =?iso-2022-jp?B?SkpxdUhYT0paaldtTGVsZ083YlphYjdmbXpJbTlDMnMrQmFYcWg5ZHlh?=
 =?iso-2022-jp?B?QkVwUHlna3I3aDBNVHV0UFRhWXlnUHozbWpHSi9ZRkxzaktTS3NIZXpp?=
 =?iso-2022-jp?B?NmwvTTFlK014ckxQZkxwd05iZ2pGV1VPbWhUMFkxc1pBL0hJQm5VQ3BJ?=
 =?iso-2022-jp?B?RGRpYWR6dWhxaUVUM05BbmxyRzZib0N6SklhTitTOHl1L1ZhODN4amNL?=
 =?iso-2022-jp?B?b05ESWl4bTUzZFY0d1UrR1oxS3lyZlJGUitUeGhOZStaa1NjMFJqREh2?=
 =?iso-2022-jp?B?VmhGd3pzZkdodGFoOGtGb2drS3g3ck01aHV3WWlIWk83TStWWjRSYkth?=
 =?iso-2022-jp?B?QlowYUtLdlRnTmhnMEt6Ni82dWpMZlpCVjBkK05FR1BxK1Z4b2U1dTRj?=
 =?iso-2022-jp?B?ay95TVJNMkFWMkd4aG92b1ZZeFIxcUtVOHZRbGNWWVQ3cEpHa0tsTnNV?=
 =?iso-2022-jp?B?WHVhU289?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd93d0e1-2dca-4af7-c43a-08dd5d5e55e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 09:56:30.5783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xEy0TVmYUyooxoz0mAzfCgFd4/24lLazksO/YKKaHOEwkeno+pwJQ0Br8wvql+EOCSlby5Yv3cEYjwGeuSXLO5Xfs8PItV++HiS7MH8erPFoWT5hGvI2HJ4B48Jvjbhm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12347
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Mar 2025 09:56:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18069

Hello Chris,=20

Thank you for your prompt reply.=20

> Our LAVA workers all run the same Docker container provided by our fork o=
f lava-docker[2].
> So, if you add your keys as part of the lava-slave dockerfile[3] then you=
 won't need special tags etc. - all workers would have what you need.

I understood, thanks. I will send the MR to lava-docker repo.=20

> One potential issue - are you adding private keys?
> If yes, would it be an issue if they are made public within our lava-dock=
er?
> If it is, we'll have to think of another way to keep them private. =20

These keys are part of OVMF Debian package[1].

In fact, in current lava slave machines (tag: swtpm-jobs), the bookworm rel=
ated OVMF files are already installed (/usr/share/OVMF/*) so, we just need =
to add trixie OVMF keys as well for our testing purpose.=20
I don't see any security issues here.    =20

[1] https://packages.debian.org/sid/all/ovmf/filelist=20

Thanks & Regards
Shivanand K

-----Original Message-----
From: Chris Paterson <Chris.Paterson2@renesas.com>=20
Sent: 07 March 2025 14:00
To: kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Shivanand.Kunijad=
ar@toshiba-tsip.com>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsi=
p.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B=
!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; ashrith s=
ai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Sai.Sathujoda@toshiba-tsip.com>; cip-d=
ev@lists.cip-project.org
Subject: RE: Add trixie OVMF keys for testing=20

Hello Shivanand,

> From: Shivanand.Kunijadar@toshiba-tsip.com=20
> <Shivanand.Kunijadar@toshiba- tsip.com>
> Sent: 07 March 2025 07:05
>=20
> Dear Chris,
>=20
>=20
>=20
> I hope you are doing good.
>=20
>=20
>=20
> This is regarding the improve test coverage for swupdate and secure=20
> boot activity[1].
>=20
> We have a scenario where we need to verify the secure boot with=20
> mismatched keys, for this we plan to use trixie version of OVMF keys=20
> to verify the bookworm secure boot image.
>=20
> It is working locally and throwing an error =1B$B!H=1B(BAccess denied=1B$=
B!I=1B(B as expected.
>=20
>=20
>=20
> So, it would be better if we add trixie OVMF keys in any one of the=20
> lava slave machine for this test scenario. We can use tag option to=20
> force the job the to use the specific lava slave machine for this purpose=
.
>=20
>=20
>=20
> And also the zchunk based swupdate is only supported in trixie version=20
> as of now so, in order to verify zchunk based swupdate on amd64, the=20
> trixie OVMF keys needs to be present in the lava slave machine.
>=20
>=20
>=20
> If we add trixie OVMF keys to any one of the lava slave machine that=20
> device can be used for these two scenarios. What do you think ?

Our LAVA workers all run the same Docker container provided by our fork of =
lava-docker[2].
So, if you add your keys as part of the lava-slave dockerfile[3] then you w=
on't need special tags etc. - all workers would have what you need.

One potential issue - are you adding private keys?
If yes, would it be an issue if they are made public within our lava-docker=
?
If it is, we'll have to think of another way to keep them private.


[2] https://gitlab.com/cip-project/cip-testing/lava-docker
[3] https://gitlab.com/cip-project/cip-testing/lava-docker/-/blob/cip-lava-=
docker/lava-slave/Dockerfile

>=20
> Please let me know if you have any other idea.
>=20
>=20
>=20
> Please note that we don=1B$B!G=1B(Bt need install trixie version of OVMF =
package,=20
> just adding below two files in slave machine is sufficient.
>=20
> OVMF_CODE_4M.snakeoil.fd
>=20
> OVMF_VARS_4M.snakeoil.fd
>=20
>=20
>=20
> If this approach is okay then I will send these files in email.

Please could you create a merge request [4] instead?

[4] https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_requests=
/new

Kind regards, Chris

>=20
>=20
>=20
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/120
> <https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/120>
>=20
>=20
>=20
> Thanks  & Regards
>=20
> Shivanand K


