Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A217DC27C6E
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 08:33:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.6671.1718354017375198718
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jun 2024 01:33:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 45E8XWIi2430513; Fri, 14 Jun 2024 17:33:33 +0900
X-Iguazu-Qid: 2yAbXhlxP3koc45GC1
X-Iguazu-QSIG: v=2; s=0; t=1718354012; q=2yAbXhlxP3koc45GC1; m=kMEmhT4XVUfjd6oqaXJfn5ugM4vu3NBcu+MuPA5tKFM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 45E8XU0c2592583
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:33:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfkEaZK/rgZ7X+raVlEb+auJzXs5JnTPY1pRt/xsLQpgeeOGx+2FCyFcNnCCFxq1O+k6HDP/tBnH5vvpVsbr9gDRFH2+HP/M4twreLl0cyZ9Rco9qcmVEHb5XusnhczMY8loGniNPjd77Q8KWSsdyyYBADioqvKPNBB5cZ2x7H3+/pjopVjyPovdG3QP9AiXJN2gJgLQxkG7ENH2mDZ8VHhw9i0sLW7e0qzjdAZfJ6t7woOAUVwPyR3LzFR0/UPeWW+v7uhDXUAZmRw/6Euv/wAdB8/K5dYenslbTwnTiyB7hR0m+E5f9ABnqyZiXOlH/1ooQHB6dP4PivqGr+oaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvPPNKCdaP1RVkm4j26DKk+j1adHnBdQjQRkg45SxgA=;
 b=Pf1vIf2ZFOkJTAktnbXfIK5gtKe4cNeRydajjKxw44U6n56Pj4N5hR5Hsl8COGNlX+hxpXsEd1HPzHFpPDPrkFB5im2Z3WvzzYeMFVZTE7Er8naDhJ14pboK++O3AlAjvDbQU9/KCDFIMtfq1Lx1/ZWI5Yt3Zq3StL3rzSez6DVqUhOEmXAlayw76+uQqvN6xUmhzSXgY85Mvv/a2ueFZbkdsbeijCENneJlo5JIGA5Kvb21IKwLj6raaLEDGD6uMjkkcJFJgDOtPth51nA8vu60B0IMi8DaD0X359X5ZIiJCzhzneWwtqJcP/23AhPDdRB74iCk1gOygZzhGhk2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>,
        <dinesh.kumar@toshiba-tsip.com>
Subject: RE: Artifact download failed due to timeout in 'lab-cip-cybertrust`
Thread-Topic: Artifact download failed due to timeout in 'lab-cip-cybertrust`
Thread-Index: Adq+DRGNdZZqn7OhQqy7wVWWG8yu3AAHluggAAJkqDA=
Date: Fri, 14 Jun 2024 08:33:28 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61033CC201EC5A8632D23136C2C22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB61030B7550E645EED661DCEFC2C22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB1186229B58F2B4E702B4688E7B7C22@TYWPR01MB11862.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB1186229B58F2B4E702B4688E7B7C22@TYWPR01MB11862.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYWPR01MB10033:EE_
x-ms-office365-filtering-correlation-id: 93122615-b2bd-4a91-41c5-08dc8c4caa3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|376009|1800799019|366011|38070700013;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?b2dTdjR4TU5MaU96VmRlRE12MTRYblR4N1daK0paZ1V3djdjWXc2M3Yv?=
 =?iso-2022-jp?B?MVJyY1RSTVB6dm4rYWFDSWJIem80ZGZ5U2Y0MkpnRmpVWmZqdlNwZFJS?=
 =?iso-2022-jp?B?K3dEMVhwZ0ZBUElKaVdiakV2RVpKVk5COWVxZUl1S3ZRL2hKd3M4NjNK?=
 =?iso-2022-jp?B?UDAxS0RkcmpzUXRybWVFVkdjNWtZK2hqMk1LSUhoZEJjSXFsQTlFQTZu?=
 =?iso-2022-jp?B?MCtMZjJMeUFyVnF0bnU1VWZLOXJDMUJLTE1YbWQ0WXNMYWZrdHlDVHRk?=
 =?iso-2022-jp?B?V2ZmU0RwV2NYbm1wZ2g2UUU2RTh3TTd3aDdyNDk2bHZBNEZwQUFFMzlM?=
 =?iso-2022-jp?B?b3N1VzBRb2QxdHhDVHhjUEo1WHE1VGRReURKSDVCZHE2d25RRjVLdUJS?=
 =?iso-2022-jp?B?YXNwVUhrbytzSzhaV0RzUHRnRFhGSElmQ0w0bFdrcWhuZ3VheHIyN1dD?=
 =?iso-2022-jp?B?TlEwYTVaQ2F3b1d0bm1wZU5nZGV6YVZ1QWZuTUp0SkNPa21uNVRrUWJ6?=
 =?iso-2022-jp?B?ajJhenpyOFZMZ0NyUFByTU15R0lpV1BuYUEvZGhlcWRoKzFMemErYUN2?=
 =?iso-2022-jp?B?MC8zN0VUdUxxNTM4WFEyMGRqNlc4cDMrS29vSVRvOWxqNmw0dkhpU3dV?=
 =?iso-2022-jp?B?MmxlNllod3NjSnd1OFVjVldIdnp2K1gvV1JqWkw4Z3VFNlZjbGR4YU8v?=
 =?iso-2022-jp?B?aUpVeVBuSGxTSiswOVJKWDY1NEFPMjl3YTh0RWs3ci9HKzZsd0hBcmJ4?=
 =?iso-2022-jp?B?K1RmaXlXYW5EbWdBSW9aMFhpZG1LZmh1SnJ3WGxSbEx4UDhTVDJUSEtI?=
 =?iso-2022-jp?B?L3ZHZGhVaEI2MHdVMnhjOWppMlRTTkJzRXArUTI2SFA5M1RqN21WVVk3?=
 =?iso-2022-jp?B?dTFCcDAvSm12ajZyNHloQlNTSzVsWkZvK3MwN092Z2JNaFpYVWNIVEd1?=
 =?iso-2022-jp?B?UDVFZWFONUxFWDEzOWM0RmNLaHVlcWpYK2I2S2RNN0cvL1lRQkl4SGd0?=
 =?iso-2022-jp?B?eDVKY09IcmN6UENZcEVuaEt2TFdORElSVHllS2dlUmdWV0NYMGJKV2Vs?=
 =?iso-2022-jp?B?WnMzTUNadkIyM3p5WmJWS1duUkxxanIxK3AxQktmRk5IMU5xUlMxWjNV?=
 =?iso-2022-jp?B?d01iRHIrWFk4djIrckJoOXZLcWVlQzgrMHQ1dTlPek9QM0U4T28vNGVX?=
 =?iso-2022-jp?B?cHV0MHhYeGFyV2hiN0NsV3Z6RXRtbXFhUStTZ3hmRS8xOVBzaTgvZnkv?=
 =?iso-2022-jp?B?KzArME1YRmhPeHBzWnhDa2MraUlUN09nRzZPcGhxOUxQN3VMQTMrYjVz?=
 =?iso-2022-jp?B?RmJvc25xdW1jdXlxTHBOYjlIQm5PYjh2bHp2RVdiN2FHN256R2g0S0xu?=
 =?iso-2022-jp?B?aHdRdmpSS2hCT2FKZDZBSnZPdmwyc0lmbkFxM2lyUkx1UjVvelZHMlo0?=
 =?iso-2022-jp?B?VlNiVnpoNjBEQkU2Q1ZwaXJkOU52MFdNMldPazh4K05lMW9Cb05iN0ZH?=
 =?iso-2022-jp?B?Q0pmVGI2RDNwb09oTUdGR1BtYUp3U0RzOHcxam1Nak9HSFlUdUVYdmRI?=
 =?iso-2022-jp?B?LzdSdklDL1hFRERONWZ5SnlZTlZmSVJEQUtQZXY4ZjdWSHZZbFlhQWZI?=
 =?iso-2022-jp?B?NzJhbWxPajhBT2xqWjViT25HR1VQd1U4Q2xzL1hWa0lmdnhYcndlM3lD?=
 =?iso-2022-jp?B?UFFYOWxoRUZ5aVFCcnJMTTk5YnlBaktReWhnSzY2YjJpOENEMW9Ea3g4?=
 =?iso-2022-jp?B?NXQ1MFJXUVNTd0FlN0tIN2ozKzVCSkIwcmlwd3F0b3JSeCsvVW5hWlFC?=
 =?iso-2022-jp?B?ckNuZXBhL0dzOVNDNXFxdDNyVjBJbnozU0JDMWpEem9OMFc4aDhoMFJI?=
 =?iso-2022-jp?B?cjVvVHZrL0s3Ymp2L0RDZnVYVFRuRWtjZUhKWjdSVytVQVBZdE9aTnNB?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ekZKMFFuWlB1ME1FYUo4R0RYSHhldmxxbmwwbkhCQ1JBcVhnYWpGS3p4?=
 =?iso-2022-jp?B?VmwwK1RKdXZGaW5TQzhDemFKckJPTkdpaUpVdThKaSt0WEw0ODRkb3ZW?=
 =?iso-2022-jp?B?cGVpWEwvRnNwTWsxT3FQWkEwRjNGYUFXdm8rZmZkZXdrdWVSVFAwRlY4?=
 =?iso-2022-jp?B?YUZIZURQMzhHL0JmcUF4VGo2b0VMQnNuOWQ3YzZkOSsrNTBvZVZJcWE4?=
 =?iso-2022-jp?B?ZTNHWDBkL1ZlTkZVaUlGVzV3SkZqWE9qZ2NSaysrTEc3emxxb0EzTEp0?=
 =?iso-2022-jp?B?Y0NNRFRmRXVVWlRhdUlXV0VlMjN5THNIWDdEemVqejFXdWpOSUtJL3N6?=
 =?iso-2022-jp?B?Qi9UZE0zc1g0dzF2TGcyd0dlYnRRak9RR2llZjEzTFNhRlpkNjFOY0Fm?=
 =?iso-2022-jp?B?Q1EyR2hMMEJVTlNZY082ajk3QVEwZmwrRzlydktXdE80aE55Y2ZPZjNZ?=
 =?iso-2022-jp?B?RTdYK3gzcmlzQ3lVOHJ6NjRMQ3JlQ1YvZldaT3Q4N3pLK0pPTlBBdWNP?=
 =?iso-2022-jp?B?bmhxV25oQTNjdGFQOXZuR0IweE1kZkxPL1FBdTcyb1pCUVZkbW1WOWFB?=
 =?iso-2022-jp?B?SXJhZnJwRW1aUjl6REVYdXltVlZSVHJpajl0NTFyd3BhSEl1MWIvckdy?=
 =?iso-2022-jp?B?aVJzeXVKYUlka3ZYdU42cVZmaW0yRzdyV2JsUWtmUVhVK3E5a1RUV2Js?=
 =?iso-2022-jp?B?NHNwY0g5cmtiK3p6dU9EMlB2V2lNR0ZTaHBHN20vRlkyWFR6NjliamFD?=
 =?iso-2022-jp?B?MTdraDEySTdZaENrd21ZVVcyQllMVG5BeG9vQXQyZldJNFk3N2d6OFdv?=
 =?iso-2022-jp?B?eE9iNlR5L3pQaUM4d2NxVnNESE9NQ0RuMjk3SFB0SWV3eTFnN2l1b01U?=
 =?iso-2022-jp?B?YlBRYlJLQTZKUElqY1BVQjI5U0xFWVU4K2sxUjJ3aGRrWU1qUWVUUjV2?=
 =?iso-2022-jp?B?VXVDS2xDODNlRWMwTUQwREUvbzM5djdXcTJrME85d2h6WjRSeHZjb2Nj?=
 =?iso-2022-jp?B?SE4xeFFPQ0p5RkNBQWRjR2JHS2VmREFhZm5keng5SU5VaGFtU1VWQ0dV?=
 =?iso-2022-jp?B?UkhlUEs1WW5yWlV5cFRYNzE4ZkZwM0R3YTlwQkFtOUxSUnJYY0F4Ulcv?=
 =?iso-2022-jp?B?cm5hNnhuK082RWRoeVo5ZVZJdjRnM1poNGhCQ3J1Z3puZVpRd3ExVldY?=
 =?iso-2022-jp?B?OWlmZGNJWmtQRS9MTTZWeU9ITEJXUEkxVURpQnZ1MDR3YWhXMWZ2L3pr?=
 =?iso-2022-jp?B?SVJuSk1Ba0NNZEpQYTZzR2QreXRQd0UyMUxuSzk4cUpqZXA2b2c2dVFU?=
 =?iso-2022-jp?B?bVRQdmFpMkoyMXd3NTJJU3doakJTS0YxU1hBSnMrdXdDbVorL2Mzdktt?=
 =?iso-2022-jp?B?R3NtUS9CNzQ0TWJjZStRVlRYelRyQ2F5OGZnQitVZGUvQys1L1k3UGF5?=
 =?iso-2022-jp?B?dTI4MWF1bmJqbEVCOEdKL3pkUTdGTnpaUnU5TXpVcThnKzFaMXhpTnVi?=
 =?iso-2022-jp?B?R1dwdXh0SVIyR0VlY1hXVmFSUU92b2R6dXBiUjFhUXhtbmRBSDJVUm9k?=
 =?iso-2022-jp?B?UHYzNThQelJVTkxmUmxiNENFNlpGTG5ka1dNbXRmMll3YTJpS2JZZlpL?=
 =?iso-2022-jp?B?MUNleTBrQjFuRFRQYjJsSkV2RU9NQ2ZsNTZyS3BveTdPM0UrQjNDUTBs?=
 =?iso-2022-jp?B?VXQrM29wOFRrSld0bEJrakpVSmJKTGlBMkUzN29WNURPNE9PN2duQ043?=
 =?iso-2022-jp?B?c1ZSMXQrVGdPTXRYaDgwakF1cjRnY2laQ1pBZkg3Nk1mMmhBcXhTMWY3?=
 =?iso-2022-jp?B?cjNaU3V0VUMyV05YVHlCcWVSRExmR0ZjdHF3cURnbFNnWUErbkwvMjkw?=
 =?iso-2022-jp?B?RlNpaVgyVyt2ZE9GaVhHU0EwM1hFd2lla293RXVOUGJ4ZlE1eDVGN3VK?=
 =?iso-2022-jp?B?QXl4bEtxN01waittbWtCb0FDZU9tWG96UGVuUnlrYkM0a2tmdW5yWWRX?=
 =?iso-2022-jp?B?dGhYTE4zbjRCNnBHSFRuRU0vVmxUZ0tpekxYQW1Pa0UxTnpVUXFLVFV3?=
 =?iso-2022-jp?B?NnlTSjRIOTJSb241VDZRaVJzS0dmNnJLSzFkcEVUWnpNbUJrdG9XeWZo?=
 =?iso-2022-jp?B?Z1o1UjliM2pnNlUrZlA2c2hscFRFZ3lQUU44OVVKMlBKUk1wZHV2ckNH?=
 =?iso-2022-jp?B?cE1FaFkzWUhRUDRMMldkNi9hbTY0a2Yrd252bmR4eGdobVg0aldkZWJM?=
 =?iso-2022-jp?B?aHhsck53MEp0c0FwWDVpVFIwdk9wbzBHMlhTbkZhU1dYMVNsTEE5ZEFJ?=
 =?iso-2022-jp?B?b3FGbVlrNDE2cjZ1MGcwaXhmTVBnZTNnUEE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB61033CC201EC5A8632D23136C2C22OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93122615-b2bd-4a91-41c5-08dc8c4caa3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 08:33:28.0916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTtschJbsD0eqlKGUY5HzXFBnoeOAJ/08BhqR0QGMxE+za1Z3I005UWEorvzRjAhX37JOl50e+AIylnmVgare44QBbiwNUKlK7MHsss/u5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10033
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jun 2024 08:33:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16231

--_000_OS3PR01MB61033CC201EC5A8632D23136C2C22OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Thank you. After the jobs are being triggered from isar-cip-core pipeline, =
I have observed that some jobs failing due to action timeouts. Based on you=
r suggested mitigation, let me increase the action timeouts in the definiti=
ons.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

From: Chris Paterson <Chris.Paterson2@renesas.com>
Sent: Friday, June 14, 2024 1:01 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; jan.k=
iszka@siemens.com
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com>; cip-dev@lists.cip-project.org
Subject: RE: Artifact download failed due to timeout in 'lab-cip-cybertrust=
`

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

From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>=
 <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Friday, June 14, 2024 4:49 AM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>; jan.kiszka@siemens.com<mailto:jan.kiszka@siemens.com>
Cc: dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>; ci=
p-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
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

--_000_OS3PR01MB61033CC201EC5A8632D23136C2C22OS3PR01MB6103jpnp_
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
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hi Chris,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thank you=
. After the jobs are being triggered from isar-cip-core pipeline, I have ob=
served that some jobs failing due to action timeouts. Based on your suggest=
ed mitigation, let me increase the action
 timeouts in the definitions.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks an=
d regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sai Ashri=
th Sathujoda (T S I P)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none">From:</span></b><span style=3D"font-family:&qu=
ot;Calibri&quot;,sans-serif;mso-ligatures:none"> Chris Paterson &lt;Chris.P=
aterson2@renesas.com&gt;
<br>
<b>Sent:</b> Friday, June 14, 2024 1:01 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"JA" style=3D"font-family:&quot;=
MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><s=
pan style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none"=
>) &lt;Sai.Sathujoda@toshiba-tsip.com&gt;; jan.kiszka@siemens.com<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"JA" style=3D"font-family:&quot=
;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><=
span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none=
"> TMIEC ODG Porting) &lt;dinesh.kumar@toshiba-tsip.com&gt;; cip-dev@lists.=
cip-project.org<br>
<b>Subject:</b> RE: Artifact download failed due to timeout in 'lab-cip-cyb=
ertrust`<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Hello,<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Sometimes th=
e internet is slow in some of the labs.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">The only rea=
l mitigation we can have is to increase the appropriate timeouts.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">I had a quic=
k look at using LAVA to
<a href=3D"https://lava.ciplatform.org/static/docs/v2/actions-repeats.html#=
retry-on-failure">
automatically retry</a> upon deploy failures, however this only seems to wo=
rk for failed downloads, not very slow ones.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">The timeouts=
 still fail the job when hit.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-liga=
tures:none;mso-fareast-language:EN-GB">Kind regards, Chris<o:p></o:p></span=
></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none">From:</span></b><span style=3D"font-family:&qu=
ot;Calibri&quot;,sans-serif;mso-ligatures:none">
<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsi=
p.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujo=
da@toshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> Friday, June 14, 2024 4:49 AM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;;
<a href=3D"mailto:jan.kiszka@siemens.com">jan.kiszka@siemens.com</a><br>
<b>Cc:</b> <a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@to=
shiba-tsip.com</a>;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a><br>
<b>Subject:</b> Artifact download failed due to timeout in 'lab-cip-cybertr=
ust`<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">Hi Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope you are doing well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Yesterday I noticed that jobs which run on =1B$B!F=
=1B(Bqemu-03` device in `lab-cip-cybertrust` are failing due to a common is=
sue i.e timeout during downloading the .wic artifact.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://gitlab.com/cip-project/cip-core/i=
sar-cip-core/-/jobs/7094898973#L699">https://gitlab.com/cip-project/cip-cor=
e/isar-cip-core/-/jobs/7094898973#L699</a><o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://gitlab.com/cip-project/cip-core/i=
sar-cip-core/-/jobs/7094898970#L985">https://gitlab.com/cip-project/cip-cor=
e/isar-cip-core/-/jobs/7094898970#L985</a><o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://gitlab.com/cip-project/cip-core/i=
sar-cip-core/-/jobs/7094898965#L670">https://gitlab.com/cip-project/cip-cor=
e/isar-cip-core/-/jobs/7094898965#L670</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Do you have any idea about this Infrastructure error=
 ?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_OS3PR01MB61033CC201EC5A8632D23136C2C22OS3PR01MB6103jpnp_--


