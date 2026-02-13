Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2D7EDF15D
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 12:55:23 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.70793.1770987312726298692
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Feb 2026 04:55:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=c4wCDpkb;
 spf=pass (domain: siemens.com, ip: 40.107.159.44, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGmoBPl24vIf8Xn70YKcyq48BrSkWW/dz7eZphfqSWnOLtuS/ckYGwI7rcputww4Gr8Lp/AWKoD7wnsOF/gqBTIPxwIw+fCBNtY9U5ivg1pEOVRZv0k0CvD2RNWgz0yjRx++JzSG4E/9oordrRM/1JRm4wikQL1iQcK28o6wY38SLn5LTBUv5SnxLC6e/FW+EJkAFjIhd7rtp99B4eIsc3rE2yGkLjFky4zkJPQINpGAmbTHcXqwT9z1931pO3V9ayLvaZuQ8awYpzvKq4tXHhGfA8U/xFh7o6Ph9IV3nimUpLzNPdGLLurFCNgquA6MeVl8d0i3Ym465zGjRhnZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwZ6MrFKLfeN2YVPaN2Qz/58Qu93K/AfDrIIOYwu3fQ=;
 b=UuIcu52nbI7Qx3NZI521T1o4+CqEHGrwQUuBxgl6f00n/D2zGw9HS2lmSurtQD0yVGSJY8y0GBGEg+K17f+d3sjXNqKl3AIgtE+56f8wfLdYVZc0t+ZKk+5747xDSLhM6O7Rt58P49KyRweZEmonuslmhVGiMxwfnUfmC5njyFpHz+O7/PA6XX3SMRSzPwUWCOPDG7KJNbSzHGNWjqM8ma6YiExMuGHegajqhtFFmkNAwloObnN6iyG7P2erYuZnGC41LGM5nhwCZBkXU7Arq1t+OpzCAiv8mci/Bj4Sdys74xFUNknwkaOcIwbxz9rdvUYaisl6VI4PosxmNKEsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwZ6MrFKLfeN2YVPaN2Qz/58Qu93K/AfDrIIOYwu3fQ=;
 b=c4wCDpkb8dS8ZzKm+z3wbTBJyWYPza0DsspYLoiMrYWODcQuFuvmNRAvjbLBCqsGeHYa1kEBNZWr7JQM4u1L/D24Eo4bzZj+72oBvUWddYaFSgCPUHwYqsJG0MqE42TbpeyPzZVI7zPu7iBSWuHPg0fXtl0i8X0uPUb4YDVLszzX6pRFZ7MSPmncpiM0LCXp0fY1luR8bTQl3UEbr2PazWiuhkAVDuXBsk9uMiWyFRjffwC0wOvXV24nBh1yXXBMD9m6cPThSzGgA/GCMw4kOH0hUGf0oe7Px6Oijt0hXDFm7MjqiHGll175/sT3Pa4vM1SenBMUcm50tn+N/0J8Nw==
Received: from AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:617::15)
 by AS2PR10MB7888.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:648::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 12:55:08 +0000
Received: from AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::900a:259b:ae7b:828]) by AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::900a:259b:ae7b:828%5]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 12:55:07 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH v3 1/1] swupdate: Enforce signing and
 verification for swupdate by default.
Thread-Topic: [isar-cip-core][PATCH v3 1/1] swupdate: Enforce signing and
 verification for swupdate by default.
Thread-Index: AQHcnGguJ9VY9B3/5UOw0QMNt222y7WAM+8AgABjMgA=
Date: Fri, 13 Feb 2026 12:55:06 +0000
Message-ID: <ef6831b618ace68c2a97cb8147aee606cd91faaf.camel@siemens.com>
References: <20260212214003.734787-1-alexander.heinisch@siemens.com>
	 <20260212214003.734787-2-alexander.heinisch@siemens.com>
	 <779171e4-d002-44b1-a7e0-879af3bed946@siemens.com>
In-Reply-To: <779171e4-d002-44b1-a7e0-879af3bed946@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-0+deb13u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB7349:EE_|AS2PR10MB7888:EE_
x-ms-office365-filtering-correlation-id: f35eb473-514a-4d3a-3fef-08de6aff1d16
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Rms4Z3cyRUlld3l4MGNXRDZCMThPQ3FNcjFoRm13QmFzRFhKcHBtcmF2elVy?=
 =?utf-8?B?ZGZYN0lYRHRZMDN5bDRZSFBZRzhieHJrWm9HdGNDMTlQMTNveHZQaG8xN3dO?=
 =?utf-8?B?U0FlNWNmbFFQVU5Yb3o0UkZKbkpvSDZjbmxKYmNaMENYdHhsV2ttQzJQV1Ro?=
 =?utf-8?B?Mnd4SVJqK0xxVUlqVXFXMlU0em9Rd2tlUndaM2RqVktZaHhHeFN1aUowVDha?=
 =?utf-8?B?VDRVMW0zbHJYWHFTM095eU52VGpscGVhMm53RjhzY1BzZHZwTlJ4Z0tVMkpV?=
 =?utf-8?B?ZHZuSVR0MXNLcjROa21hTU1BckdXdXFHTTEwWnNPMm8zQ1RzK3dQaDYwVWZX?=
 =?utf-8?B?RG9pc0lkWDFnUHg2VXlsd1Y5QmNLcVgwMlgxemRuRVhiZU9kWExSbEZVSktl?=
 =?utf-8?B?MXFZSDc1N3czL0hGcXlOZHdwNlF2YkpQeWtBenlXMDYxamJLaFJVMWVnTkNM?=
 =?utf-8?B?Wlh1U3l5QnFuR09uN05LSlZhaHZhRW1GWW9lYTZLQnZMdU5lWTM3bHVaYmZ2?=
 =?utf-8?B?K0tTM1I4WTlFdjNtYjdnMC9TWW9wNlFMVzhRZXRkQVNuL1B5YkhMc0tkRU5k?=
 =?utf-8?B?QnZGaXA5Zng1dDVCK3Z5REMwbFRycnFDdVBzS1JaQnA0azc2V2t4OUlOdHNi?=
 =?utf-8?B?YVZrNzN3NkMyQkE4MFhabGJMYnFINnYyeTdqZFBlY282VWlYcmlab2ZHMW01?=
 =?utf-8?B?Z0Y2QUV3Vi9ZS1pJNUZKRmRqMnlmQ3h3dmx0cHlteXJMOFhyQ21mUzVSWHNY?=
 =?utf-8?B?cStCc0xGSjJDZmJ5eE1zQ2dKdzFCZkxMOXUyUHBhSUJBcEtZR29nMVVHOUt6?=
 =?utf-8?B?YmdmZVhEQWRENDFaL2Y0Tm1wN1FzMzk0QVQvMmhPU3hxdEJyVHNud2U0VWRG?=
 =?utf-8?B?Yk5mUThpNmFpRDRWLzBYMWhrYzNyakEwOG1WSm5mY2lGa0g1RmtLN2Y2YUlP?=
 =?utf-8?B?NzJYOTZwS0gzRUV6OHhBbHdXcytBTkI3UzcxMnFxODRKZCtMMTNxRmJEZkFK?=
 =?utf-8?B?OVBSQ1oxUzNsQlVWcGtPOVVyZ2RqZXM5Y21UYWg4b2xsUG5OcFhYSUU3WkNI?=
 =?utf-8?B?eVJMOFY3VTdrOU8zdkZ3N2xKeVphc1ZpNGM4cFc3bEV3d2prL0xzV1RtN2o5?=
 =?utf-8?B?MTg3VHRZaURERlVUQnBvQ1Zka3IwUzc2ODJhejhubE1qNVBvK1lhZ0VVeXhM?=
 =?utf-8?B?STZWeCt1ZnlnVStJTzIvM05FeVlDWXhGT3haRXlnMmJvaFdQR2hEMDVWeFBi?=
 =?utf-8?B?aHlBdFJxSGVBaTh0SFpWeW82R2NCdWpPRG9LbVpZdTg2T1M5RmhUaHdrQVQ4?=
 =?utf-8?B?VlR3VG9FcXA4RGpmcEhMeFV1TlpDN29lYWRhNUM3OGFLa3FnLzg5anQvbVQ4?=
 =?utf-8?B?WXp2VTFFLytCc1VDRjlwRkhWYlpWRDRUdTJlY0xXR01BSFBWS0lEV3VpSEZo?=
 =?utf-8?B?MysxVk5TMjhaMjNLVnRmU1lRWlBlUFNiM0dNcnFIOGx5LzlUMjhxbUpJOTJz?=
 =?utf-8?B?SzdSMklLSDVoWUk3SnAzbWxScEF3N2VyZ2hsU3V3OG1tQm5Rakt0bnVGY2cy?=
 =?utf-8?B?RDN4RGhzcHhiWmRUQzdiT2gxUEF1bUw2amdWTW1XdkNwRGlwb1Q1RmtobEd6?=
 =?utf-8?B?c1RxWEJxYk83YUg5dW1DV2ZqeHR3MjYvQVp3ZkxQZjlNZ1dBemdkejhvdlJt?=
 =?utf-8?B?MDNCYlZ0N2gvMWJsRlRCSE5XZlBqN21kRWhxVDZBN2tMdGRCQy8yVURodVE0?=
 =?utf-8?B?Y0VaMkk2bGYyWEhRSmlHRjZmYkNsRGdyNWRPMkFTUGFwQTRyZkpPU3MxVVpl?=
 =?utf-8?B?ODlzdVU4MVYyM2RGclFZTERNcTAreTJQdTQxdWlBVWd5SHEzVWZTMG0wb1FO?=
 =?utf-8?B?cEFlYytrenpxK0FGTGkvWVNiTnErdmx2aElNZGZCekU5djkwSjkrQXYxTTJS?=
 =?utf-8?B?NDFyMllyLzh1VGNQVFNKYkovc0t6S20zWTRBbi9hbC9xdE9TcTFpMXQ5bFJK?=
 =?utf-8?B?bTF1RGZqc3hqbDBIUVcwVUtMbHJaOU5Qa2JpeDAyeDNjMkxTeFpqbWVuT0h5?=
 =?utf-8?B?MHNrN1pyRlZLVkQ2bTlCc2h1U1V5VVJKYWxBVGNweTJpMW5mc3o1M3UrMWRK?=
 =?utf-8?Q?+9Zf4cwu6No52jJJGPpLuoSG6?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SDRQNTNHUXdiNXh4ZW5GRTZYVFhabFIwMzh2V1MxeHhwTnV3N09ucm1jbEVN?=
 =?utf-8?B?VnZPeDNoM2VSNmh0OXIzTDNaSGovWUkwK2JhTVdNcS9ZNWhHbmkwejJvbHMy?=
 =?utf-8?B?R2hrekZNWGdqWjRhcnNyK2VIMjZPOUgvcVQ2RlJ2czAwVjlFMEwwT0VyTUVy?=
 =?utf-8?B?K0kzUzNZQ0dHcmlIamNhT0Myd0hPNkNIZjNVMVROSnBiUitjOXNBdDIwNHky?=
 =?utf-8?B?YXZyVW9kZ0o1M0pqeXNmRFZxQm1jTjlqekpINzdsY0lnYUNGSldkZFdCdkVY?=
 =?utf-8?B?NElVdVBNajBzcUNUSUR5YVFKcHU5bTZCSVlSZHRsdXVSODZrMjNUZE9uZ2li?=
 =?utf-8?B?QXRzMlVFQmhDRFI2c1U1STdUVUFZTGlvdWZHQkV0WlIwWTU0ME92K1p4OVVo?=
 =?utf-8?B?Q1RPWVg4ck91ZmplNzQ0N3pqdXN1NVdjWjRLRytZeVJ4THhCT0N4M0VmeVVv?=
 =?utf-8?B?L05tendxVzNmZ0RpV2RPMkw1Y21QNmw5SXc1Y1lWWG9MZVhVY2VpRGVWK2s4?=
 =?utf-8?B?NDl0ZGNaNTFHdzdQcVhFVmFkcm5mODhueDBvUDBBOUJ6Vm5UK2dxaDBVWHdR?=
 =?utf-8?B?RU1MYVBjUUtVWXJsZ1VCNmtjMVVodFFkTnlyL2Q2Vzhqb3ZrTUlVQU1qQjBq?=
 =?utf-8?B?dlhRdWVUaHZVUUpHSXdQb3ZoOVBnZFFvKzV0NmZ5QWt5Rm00TXlhV0IwTUor?=
 =?utf-8?B?cXNYWUdTUmIzeXBBT0ZvSy96SE0zaVJXYTFRS3U3K0ROOWFTRDlVeEZzYitj?=
 =?utf-8?B?bktGL2lUcWh1eENCUTEwanJNNEdDUWIzclRlN0ovTzJ5TVhpdjZOMXAyeWpu?=
 =?utf-8?B?UDltcGI5KzBoME9RSEEyc3pwbkc3UE04SE1aWHd3cFBIUlhXVHJhREpHWmIw?=
 =?utf-8?B?OC9FdENVSmpvcXlTT3Raamt0YVR2cjhHc0JJZU1tRFZ5ZWQ2RS8wRmZzUzJO?=
 =?utf-8?B?eUxKbTdCZnVRMERaRXIyYnpRRjdIUkZsczY0dzlUb0lwOE9uRU11bXlpbVdM?=
 =?utf-8?B?RGdNc0kxb0RNZStjYlhRMVdPTGhZMlJpVEJpMFExb0hUZnhCWmlqOWxJVjhr?=
 =?utf-8?B?Rkx1SDRWNmZPMit3L1l2VlUwYy85dEE3VUFFVXBQQlh0dzNEcThaby94bWZo?=
 =?utf-8?B?R2thdGZJZHJVZE44LzdWUThSaE9JMEtUZjArTWs3SnZqOXNwaTNvMU9TRGwx?=
 =?utf-8?B?WVVsQm9uZnVzVEUwTTVTS3M4cVNPNTZJL1V2Rk1JSllsaitKajRSUHVacDc5?=
 =?utf-8?B?aUtJRHBUUXRmYTczTFQ4NzRJSnBBOHQyNGtsYVhtL1NtT2hKWTVSM09WcWx0?=
 =?utf-8?B?L2hGQnljeXIwWU9DS0hyaitZSnJqNWF2MW9KR1lTSnBiajU2RzBFZmhCL3Ji?=
 =?utf-8?B?SStLd1pNaDBua1ZhUmNhU0JyazFJVlZKeUYrNVF6Nm52aldmaUNnWDdzMEVn?=
 =?utf-8?B?YUhmVjR4YXhNYmJlUTBodjl2dEpDUjVoampxMmpDMWlRNWdmNkkxbGFqVzh6?=
 =?utf-8?B?Q0J0TkJsTTc0SHYyNlQ4QTk5UHhtOTZiVHp1a2ZLaEdLTkZRa1d0eitXMjFq?=
 =?utf-8?B?amxuN3FuR01vVktOZ3pXM3dyeTNJT1Zjc3lYNnc1Q3g2VStnc3VUYW9nbnBF?=
 =?utf-8?B?S1V2Qm9jS245TENYU2RrQ1VaTzBRSFRZVThtZ0pDL1VyekZMVEowUkkxeHJM?=
 =?utf-8?B?M1dEZmd1clFhNlBSUU9XTEkwQmxGR01ZV0t2c2N3QUoyTExEbysyOTNTNEYv?=
 =?utf-8?B?dXhLc3BWdVpGVDljdFMzOEs2NCtFdTZ1bFFVNDZaRnIyVC92VnlCaDhpc2Vt?=
 =?utf-8?B?dHRPc0hvZFU1RHZEUVZFTkVyaTVQVVZOZVFIRll5bk84dXVmMDFiZTNoQ3p4?=
 =?utf-8?B?Q2ZjMEluYVpZY3JrUTdmbW84clVLejBLOEVuazdSLzlERmNQWVhJNjhWWklx?=
 =?utf-8?B?NmplNXFsM2dtOHloWjlRbm9KMWhaUUNUZWlIRjhaOUUybFJLVFdEU09YL3I1?=
 =?utf-8?B?cCtlTmN0d0tSd1k2Y1ZVei9DUmp5bmt5bUFDVHIyODVHREJrcjNzSVpJdXhq?=
 =?utf-8?B?MWsvN3M3dTcyVmEvd09WcTNwQ2l5R09tbWdiUHR0YmxlU3AzUGdGcHN0K21T?=
 =?utf-8?B?TmQ1ZUlOOTV4elZLL0J2R3FDdGxuZTc0M3VnRHFZY2dMY1ZZeXBIdExpRCtD?=
 =?utf-8?B?Q1hyUkY4Mi9OVXlNSE5zWWxJbjE1SDNqd2dudmN1S2pCWUlGOU5LVzE3NWhw?=
 =?utf-8?B?cE52NG5hN2Q2dGp1SjZOV2RyU3M3endIMTFmQlJKN295b0Y4aFBNUm1OTlBo?=
 =?utf-8?B?dHd6WUVRWnhkUnVROVdiR0EzL3A1bXlLTEY5T2FzYjFvZ2p3QU5jaWI2Tkx4?=
 =?utf-8?Q?ezZA9pYhNjDGAWO9vGMf0WHZIDYBkPXF289XV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <259346B3066ACD419E974EAC60EAE31B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f35eb473-514a-4d3a-3fef-08de6aff1d16
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 12:55:06.9432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jd/vu1JX8L9ujLMjsknGfjk23BZJXZBR8RJObTO+MJkVrLe3WWn7jt/IeakM/aWvqpCioWPng9Fjly8+cfW2IOZiQ3L2ZVCqTjeMU8YIS6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7888
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Feb 2026 12:55:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21874

T24gRnJpLCAyMDI2LTAyLTEzIGF0IDA4OjAwICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxMi4wMi4yNiAyMjo0MCwgYWxleGFuZGVyLmhlaW5pc2NoQHNpZW1lbnMuY29twqB3cm90ZToN
Cj4gPiBGcm9tOiBBbGV4YW5kZXIgSGVpbmlzY2ggPGFsZXhhbmRlci5oZWluaXNjaEBzaWVtZW5z
LmNvbT4NCj4gPiANCj4gPiBBbGlnbmVkIGRlZmF1bHRzIGZvciBTV1VfU0lHTkVEIHRvIGVuZm9y
Y2Ugc2lnbmluZyBvZiBzd3UgZmlsZXMNCj4gPiBhcyB3ZWxsIGFzIHZlcmlmaWNhdGlvbiBpbiBz
d3VwZGF0ZSBiaW5hcnkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIEhlaW5p
c2NoIDxhbGV4YW5kZXIuaGVpbmlzY2hAc2llbWVucy5jb20+DQo+ID4gLS0tDQo+ID4gwqBjbGFz
c2VzLXJlY2lwZS9zd3VwZGF0ZS5iYmNsYXNzwqDCoMKgIHwgNCArKy0tDQo+ID4gwqByZWNpcGVz
LWNvcmUvc3d1cGRhdGUvc3d1cGRhdGUuaW5jIHwgMSArDQo+ID4gwqAyIGZpbGVzIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
Y2xhc3Nlcy1yZWNpcGUvc3d1cGRhdGUuYmJjbGFzcyBiL2NsYXNzZXMtDQo+ID4gcmVjaXBlL3N3
dXBkYXRlLmJiY2xhc3MNCj4gPiBpbmRleCA1OWRhYjlmLi5kOTJkNTVmIDEwMDY0NA0KPiA+IC0t
LSBhL2NsYXNzZXMtcmVjaXBlL3N3dXBkYXRlLmJiY2xhc3MNCj4gPiArKysgYi9jbGFzc2VzLXJl
Y2lwZS9zd3VwZGF0ZS5iYmNsYXNzDQo+ID4gQEAgLTM5LDYgKzM5LDggQEAgU1dVX0tFUk5FTF9B
UlRJRkFDVF9OQU1FID0gIiR7QA0KPiA+ICcke1NXVV9ERUxUQV9VUERBVEVfS0VSTkVMX0FSVElG
QUNUfScgXA0KPiA+IMKgU1dVX0lNQUdFX0ZJTEUgPz0gIiR7SU1BR0VfRlVMTE5BTUV9Ig0KPiA+
IMKgU1dVX0RFU0NSSVBUSU9OX0ZJTEUgPz0gInN3LWRlc2NyaXB0aW9uIg0KPiA+IMKgU1dVX0FE
RElUSU9OQUxfRklMRVMgPz0gIiR7U1dVX0tFUk5FTF9BUlRJRkFDVF9OQU1FfQ0KPiA+ICR7U1dV
X1JPT1RGU19BUlRJRkFDVF9OQU1FfSINCj4gPiArDQo+ID4gKyMgSW5jbHVkaW5nIHN3dXBkYXRl
LmluYyBpbiBDSVBfSU1BR0VfT1BUSU9OUyBlbmFibGVzIHNpZ25pbmcgYnkNCj4gPiBkZWZhdWx0
Lg0KPiA+IMKgU1dVX1NJR05FRCA/Pz0gIiINCj4gPiDCoFNXVV9TSUdOQVRVUkVfRVhUID89ICJz
aWciDQo+ID4gwqBTV1VfU0lHTkFUVVJFX1RZUEUgPz0gImNtcyINCj4gPiBAQCAtNTIsOCArNTQs
NiBAQCBJTUFHRV9UWVBFREVQOnN3dSA9ICIke0ANCj4gPiAnJHtTV1VfREVMVEFfVVBEQVRFX0FS
VElGQUNUX1RZUEV9JyBcDQo+ID4gwqDCoMKgwqAgZWxzZSAnJHtTV1VfVVBEQVRFX0FSVElGQUNU
X1RZUEV9JyB9Ig0KPiA+IMKgDQo+ID4gwqBJTUFHRVJfSU5TVEFMTDpzd3UgKz0gImNwaW8gY29y
ZXV0aWxzIg0KPiA+IC1JTUFHRV9JTlNUQUxMICs9ICIke0Anc3d1cGRhdGUtY2VydGlmaWNhdGVz
JyBpZg0KPiA+IGJiLnV0aWxzLnRvX2Jvb2xlYW4oZC5nZXRWYXIoJ1NXVV9TSUdORUQnKSkgZWxz
ZSAnJ30iDQo+ID4gLQ0KPiANCj4gT2ssIHRoaXMgcmVtb3ZhbCBkZXNlcnZlcyBhIHNlcGFyYXRl
IGNvbW1pdCBhbmQgYW4gZXhwbGFuYXRpb24gd2h5IHdlDQo+IGdvdCBoZXJlIChAUXVpcmluKSBh
bmQgd2h5IHRoaXMgaXMgc2FmZSBvciBldmVuIHJlcXVpcmVkIHRvIGRyb3Agbm93Lg0KPiBJbnRy
b2R1Y2luZyBjb21taXQgd2FzIDk4MGNkMDA4OWVkMGIwMzE4OTc3NTIyODgyYzRmOWQ1MjBmNjY4
OGUuDQoNClRoZSBsaW5lIHJlbW92ZWQgaGVyZSBnb3QgaW50cm9kdWNlZCBpbg0KOWMyY2U5OGM0
MzQ3M2U3ZDlkMTI1MDhiZWQ5MjRmYWYxZDY4OGJjMCBpbiBmaWxlIHN3dXBkYXRlLmJiY2xhc3Mg
YW5kDQp3YXMgY29waWVkIHRvIGltYWdlcy9zd3VwZGF0ZS5pbmMgaW4NCjk4MGNkMDA4OWVkMGIw
MzE4OTc3NTIyODgyYzRmOWQ1MjBmNjY4OGUNCg0KY2xhc3Nlcy1yZWNpcGUvc3d1cGRhdGUuYmJj
bGFzcyBwcm92aWRlcyB0aGUgaW1hZ2luZyBjYXBhYmlsaXRpZXMgdG8NCmNyZWF0ZSBzd3UgZmls
ZXMgKHRoYXQgY2FuIGJlIGVuYWJsZWQgdmlhIElNQUdFX0ZTVFlQRVMpIGFuZCB0aHVzIGlzDQpp
bmhlcml0ZWQgdmlhIElNQUdFX0NMQVNTRVMgdG8gYWxsIGltYWdlcyBubyBtYXR0ZXIgaWYgc3d1
cGRhdGUgKHN3dQ0KZ2VuZXJhdGlvbikgaXMgdXNlZCBvciBub3QuDQoNClRoZSBpbWFnZSBzcGVj
aWZpYyBwYXJ0cyB0byBlbmFibGUgYW5kIGluc3RhbGwgc3d1cGRhdGUgZm9yIGENCnBhcnRpY3Vs
YXIgaW1hZ2UgKHJlY2lwZSkgaXMgaGFuZGxlZCBpbiByZWNpcGVzLQ0KY29yZS9pbWFnZXMvc3d1
cGRhdGUuaW5jLiBUaHVzLCBtb2RpZmljYXRpb25zIG9uIHRoZSBpbWFnZSBzaG91bGQgYmUNCmhh
bmRsZWQgdGhlcmUuDQoNClRvdGFsbHkgYWdyZWUsIHRoYXQgdGhpcyBzaG91bGQgYmUgaW4gYSBz
ZXBhcmF0ZSBjb21taXQhDQpJIHdpbGwgc3BsaXQgaW4gVjQgb25jZSB0aGUgZGlzY3Vzc2lvbiBy
ZXNvbHZlZC4NCg0KQlIgQWxleGFuZGVyDQoNCj4gDQo+IEphbg0KDQotLSANCkFsZXhhbmRlciBI
ZWluaXNjaA0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

