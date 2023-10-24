Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC83C07545
	for <webhook@archiver.kernel.org>; Tue, 24 Oct 2023 16:36:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.152599.1698165379813574815
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Oct 2023 09:36:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 39OGaFew509217; Wed, 25 Oct 2023 01:36:15 +0900
X-Iguazu-Qid: 2rWg9lIcz8qFAcYl1s
X-Iguazu-QSIG: v=2; s=0; t=1698165374; q=2rWg9lIcz8qFAcYl1s; m=hN2PAZfXlP8mw5Zke5mXabS+qI23Hj8Lijj+g+CXFmE=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 39OGaCTX4133452
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 25 Oct 2023 01:36:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzMwEAMYP9MHdNKSIsuUNU45uQPwXpF3SwHVBagTgZmLNLwlpZDLo+fcuXUUbzmgXjXEPR3aZqxy+1x2YeU3BWlH36U63gwoWb4K+kCI89QAvdixFKyj/EGqEmpE5bUKx6wBs3AlsJPyvcWirc91ofBbWW8dFWc1TU+A6RPW7KQZEq1frgrjSxc84xu7KywBFUcPYYh7FHJf4aq0j2uFb87O98uQsinUvcGeXiXLT/BXEqjP1reh/hnMvN4nOG708NyUaisKUBre2Dhgmw+Bx8QcjlpicyG1LA/vuuWnZkmWHW2vXLo8BjQkG7dg0aPf9K5DRDMD/wR2ekxi/IEB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd/yeEby5jJVzH4b5VWbLJXxkFtjlWX5t24jYLGv1sg=;
 b=VvDsR3ic7nWNEWLW1uxx8m6B4h2UL0mqqVdy9sM50GVLQt6XxItBgTbRf572g+5sn45+wwy80JKuh5siI9vXwUcsABTShkERet5K+x/4NlwL9g3R64lv5VWhZKPA1YaA7b/U9wEMFbDhPwWCtDW+gc77+wGER99GvQ6J9HnKzR/vLHikQ2r2e3TxsbDgdHlzALJqXtnavCzVm/+7WAd8fIKpKIHcAxXftI4HIB3KTdveFvy46hVixkxwmcFt1Tc+IbBPpu0der1VLaklNwAWafGDIBGJWW2G4UOcfgdD/iYPn3gYmBdBdzCcPzKr0ryg8Bo7iCEBXY4/77lC2tfnGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <quirin.gylstorff@siemens.com>, <christian.storm@siemens.com>
Subject: RE: [cip-dev] [isar-cip-core 2/2] reproducible.yml: Disable signed
 swupdate in reproducible tests
Thread-Topic: [cip-dev] [isar-cip-core 2/2] reproducible.yml: Disable signed
 swupdate in reproducible tests
Thread-Index: AQHZ+FTYiiZdDXhZKUqacI+rzfyK9LA8uqqAgAFkiGCABFwT8IAAI0EAgBaTtqA=
Date: Tue, 24 Oct 2023 16:36:09 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB685652135A62356BBEF463B4A4DFA@OS3PR01MB6856.jpnprd01.prod.outlook.com>
References: <20231006125845.2661-1-venkata.pyla@toshiba-tsip.com>
 <20231006125845.2661-3-venkata.pyla@toshiba-tsip.com>
 <c6612b4c-b17d-484f-8cab-1f204567a456@siemens.com>
 <178BDEF1D76FA0E8.24994@lists.cip-project.org>
 <OS3PR01MB685635BA1CFBAC30375EAE11A4CDA@OS3PR01MB6856.jpnprd01.prod.outlook.com>
 <f598eec3-31ee-4c3a-a961-24363e5f6a11@siemens.com>
In-Reply-To: <f598eec3-31ee-4c3a-a961-24363e5f6a11@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6856:EE_|TYCPR01MB7893:EE_
x-ms-office365-filtering-correlation-id: 94a17348-d8a9-4e4d-0062-08dbd4af5441
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wjKUwuigEyvAQD5wWAJwni7hNE28SdcQboAqSLTEt0U3Kb5DMQptiyF4bI1qTfsYD9PibyoBIda+nYc+K1fLp/zxYaVLoKyz71/F0oOXuhHphOed0yX3y65po7x/WocOkayD9RIk8qtoWg3gMA9zPWZWwDftVahfkpmFplUn0pqyXtdDaSJ2W6VzmHWqPWa0r7iYlXKbcDgvmkRJR6ONWqnnyZG2IhPunHLyGH8HVsZ5hoG/qUucUjw4Or2mpj60a6z3KT2/FLqy1fLzBY4d78o7lc27rOoLh0IUN9OXKKX+xcirk6buK2cUuwH8IDvM2eu+TxVzbe4P7mWxKIZJm1Meehc3lamh9IeoY+xqmGrG5tjxFw9k5VpUOXKcBKH9pASyzuj3bJc4pOSQwzC5zJJjQluM8Nks2elXUrc3fG8InuzNUeE1G89RnH4WlsnnMGf5pG0EJAtizplvUZvNwzmwyCau4/OX6COWbIL27gGwOib/n63l3tDaX9kqAk/LxWj+Nin3PWPj950c0ICbJcDf80bGDFiTk3xE/4RsXGdxifCI2L7IC2iKj1H9iIMCgeE/pMc9Hd0DOPoUSUbWZ3OBkFFZUoxQWPwPuMRFy38CkrzJsSotb+p0Sk6kdy+/
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6856.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(38070700009)(26005)(38100700002)(41300700001)(2906002)(55016003)(86362001)(5660300002)(52536014)(8936002)(33656002)(4326008)(8676002)(7696005)(66946007)(6506007)(64756008)(54906003)(71200400001)(478600001)(110136005)(66476007)(122000001)(85182001)(66556008)(316002)(66446008)(76116006)(83380400001)(53546011)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WjlLZUNzd3AwYmlnUDIyYURVWWN0RkFRRUJWQWxhSmZ5MmdBMkhUb0pXOE4z?=
 =?utf-8?B?TDcwT0tuNzJ6ZGtHek1wb1pzSHRnQzNmeUc0TGlqeDhRRVZrOE5SN0tsUzV2?=
 =?utf-8?B?VmM2L0haNVgxREp0ZnFkK1hDNzNkZzREbHVGR0ltVG9DSXNwTmgzaEtYSnAx?=
 =?utf-8?B?TURXZy9YV2hvUFlLeUxmcjMxV0FDT2Rjd2RvWmdvQXM3QVBUcXVBVElrSEwy?=
 =?utf-8?B?ZHRtdkNCd2IvaG9YbUtqVlArSXExcFJTQWp4eVg3eFFkeEhEL2JDcEJGTmd6?=
 =?utf-8?B?WmhIRXE4Vyt4eWlHb2hST1N2WFdJYTZxWTdGQ1Z2STZKb0ljREZjN2JLNUp6?=
 =?utf-8?B?VmRheGNzbkYvbkpZU1FXbEJLZ0VEVHhtOXp2SGFwNm5QY1hLYUFha2tvTWRx?=
 =?utf-8?B?WUF0SVpYNEM2cXdMQnJJZUZRbG9DOW82c1hFS1BmVzVaZXdIYzBRb2tWSlo1?=
 =?utf-8?B?M2RmL3FrUWVsUGlmK0FZM050eW5qZkNsTkdJTXRkZnR1OUwxMTBGUFlKS1pU?=
 =?utf-8?B?bm5BalNkVXA5bjYxUU0vbzJmOFBBaXhUNHUzaUdaeGlWSUZXMUJDeUdGdU9h?=
 =?utf-8?B?VXorVkJoQkZDU3BLRDlwYklqci84MWJ0Z0paTVpRYis2SWV0SmJRbVBLdGhF?=
 =?utf-8?B?bFZXdzl3Vkl6Z3ozYzNuSXR6NDlWbVBIOStMYTArUGRiYzhyTGMyQnd1Mk1H?=
 =?utf-8?B?bHNqRFpvNVZ4SGJTckVyL3ExbGFaUUNVTGUyWWxjNnp3Y0M1c2dyOWJlTnV3?=
 =?utf-8?B?STIvRkV5bUJ5NlRRemlNM2FsM2dma0piOCtXSVFueFlTRG56RWpJZWY3cFRm?=
 =?utf-8?B?UUpxNm54b1VyTWdYcmVLMktkYUFPSkh1Szl4OFVVSlRxMDgxN3U0Y1NHRFFt?=
 =?utf-8?B?b3BVcC9qb2Z6UW1pQVAyakFiQXhvSDNWR3RCTk9KcGhFa0ZMVmFQenJUN2VS?=
 =?utf-8?B?M3hZNHdFcVhKb2JoL0ZUb2JkWWpQUm1VMnhxZlhvTUs2THpiVlBKTDZxa3JP?=
 =?utf-8?B?MGRzNGNJd28wdDhMZi9Xa0VkNXFDTmN2TlUyVkxOSUFJMm03Q01rVzJsa3lm?=
 =?utf-8?B?eXpDRTdTemF4clA1bW9hUHZOeUpIMVNwVUlIRzI2MXc3T2pJVDhUQjFnZkpK?=
 =?utf-8?B?Z1BzUGw3aEpiRUNKTFFIVVNXek9wYzZmWXJhdjZyN25WWFVMRVU0eHBTUXNT?=
 =?utf-8?B?UFNOd0JiSkpxbFVSRkw5Wjg0a1Z3bDJkdE04Rnp0Tkc5VjVhVHBpWnoxR0x4?=
 =?utf-8?B?VkpvZWtsUFVyVGR0OWFmenRxVFhEOTg5cDJ4WXVRand2OW9talZkeWtiSVBQ?=
 =?utf-8?B?ck0wRjBxMDNYbG9EcFkwb1UrbG8wVDU4bE95dWRpT1BwRjViWmRLZFNJeDNG?=
 =?utf-8?B?TlBGZmdUeUk2VHZMMTQwSEQ2a2VyZXgyZk9UMjh3UlNqT2ZCZ1Q1SUpsK3Jv?=
 =?utf-8?B?Vmp0eCt0SUxnanVqblNSQ2d3SGlGUjJHOTFiMFc0dW5LYUVrTm1NcFRWeGxj?=
 =?utf-8?B?TVRacllWWXJ0T3h0UGdjTFR3WERma2NBUm11TElXeFZmZ0ErVkMrTHZTck5i?=
 =?utf-8?B?YUw5QjRoa1ovQkY1ZkJhMU1SZ1poQkN4NDhPWnNtNGp4SkwxS25KMmczaTcr?=
 =?utf-8?B?VHFXejdGNVVpaXhnV1NmRXR5UXMxRFp4bVFQOEg1WHRYM3hVaXgwY2hCMkFy?=
 =?utf-8?B?OHBocWRncjY1U2pQb2Y4cnR2VmxJMThiS2MzeFFKZjRDVFU5UmtTMXlYQ2hk?=
 =?utf-8?B?eC9FbTlUWjF0VitqeVlnV1UwR0hVdzdRbWxsK0Nvd2xha0VOS3NiWVdHbWJt?=
 =?utf-8?B?SDY2NjNaOXJWNXZNanE5bUk2MXJ2SU5YTkhvaVliNlpmVHAzbTBDa24zMjNO?=
 =?utf-8?B?VU1xRXB0WW1JZ041N040bVRHUURWMzF1YnNwVXBOWE9oVVEwTFFQSEtEcWpl?=
 =?utf-8?B?bDBLdmZYUkRqZjc0cEJ3UzRuS1pLZXRnc2dKT2ZrVTI4NVNRTjRZSk1DWEF6?=
 =?utf-8?B?N0dpcWtxTWVqNkVCL0N0ay9Za3FSNWt4ekpENmxvUlhlai9vVERqbGF6bGJm?=
 =?utf-8?B?cm02TDArK1R0TG02am03VnJOaHVPd204WEVHbXB1RzM4YzRaNzdUS2RhRGpt?=
 =?utf-8?B?Z3ZCRXlKY05ycGdITlM2aldJb0F2bDA4Y3luSmZwUEN5a2N3T2dYWXRrOWxs?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6856.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a17348-d8a9-4e4d-0062-08dbd4af5441
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 16:36:10.0938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJzhoODRCqEDMJIU110jZ/sJL3ae3N7/GQrkFXHhrs/Op5Yy2T+AvsItvKotRwUaFoZ5FsDkV2aVJde/CQs8hS5q5vafvDNTLLNQ0+R8itM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7893
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Oct 2023 16:36:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13444

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8amFu
Lmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxMCwgMjAyMyAx
MjozMiBQTQ0KPiBUbzogcHlsYSB2ZW5rYXRhKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGlu
ZykgPFZlbmthdGEuUHlsYUB0b3NoaWJhLQ0KPiB0c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnDQo+IENjOiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVDIE9ERyBQ
b3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtDQo+IHRzaXAuY29tPjsgaGF5YXNoaSBrYXp1
aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnvvKfilqHvvK3vvLDvvLPil4vvvK3v
vLDvvJQpDQo+IDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPjsgcXVpcmluLmd5bHN0
b3JmZkBzaWVtZW5zLmNvbTsNCj4gY2hyaXN0aWFuLnN0b3JtQHNpZW1lbnMuY29tDQo+IFN1Ympl
Y3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmUgMi8yXSByZXByb2R1Y2libGUueW1sOiBE
aXNhYmxlIHNpZ25lZA0KPiBzd3VwZGF0ZSBpbiByZXByb2R1Y2libGUgdGVzdHMNCj4gDQo+IE9u
IDEwLjEwLjIzIDA2OjU5LCBWZW5rYXRhLlB5bGFAdG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4g
Pg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IGNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4N
Cj4gPj4gT24gQmVoYWxmIE9mIFZlbmthdGEgUHlsYQ0KPiA+PiBTZW50OiBTYXR1cmRheSwgT2N0
b2JlciA3LCAyMDIzIDk6MzcgUE0NCj4gPj4gVG86IGphbi5raXN6a2FAc2llbWVucy5jb207IGNp
cC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+ID4+IENjOiBkaW5lc2gga3VtYXIo77y077yz
77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtDQo+ID4+IHRz
aXAuY29tPjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnv
vKfilqHvvK3vvLDvvLPil4vvvK3vvLDvvJQpDQo+ID4+IDxrYXp1aGlybzMuaGF5YXNoaUB0b3No
aWJhLmNvLmpwPjsgcXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbTsNCj4gPj4gY2hyaXN0aWFu
LnN0b3JtQHNpZW1lbnMuY29tDQo+ID4+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lw
LWNvcmUgMi8yXSByZXByb2R1Y2libGUueW1sOiBEaXNhYmxlDQo+ID4+IHNpZ25lZCBzd3VwZGF0
ZSBpbiByZXByb2R1Y2libGUgdGVzdHMNCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+PiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNp
ZW1lbnMuY29tPg0KPiA+Pj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDYsIDIwMjMgNjozNSBQTQ0K
PiA+Pj4gVG86IHB5bGEgdmVua2F0YSjvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxW
ZW5rYXRhLlB5bGFAdG9zaGliYS0NCj4gPj4+IHRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmcNCj4gPj4+IENjOiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVDIE9E
RyBQb3J0aW5nKQ0KPiA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtDQo+ID4+PiB0c2lwLmNvbT47IGhh
eWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDvvKTvvK3vvKUg4peL77yk77yp77yn4pah77yt77yw
77yz4peL77yt77yw77yUKQ0KPiA+Pj4gPGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+
OyBRdWlyaW4gR3lsc3RvcmZmDQo+ID4+PiA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT47
IENocmlzdGlhbiBTdG9ybQ0KPiA+Pj4gPGNocmlzdGlhbi5zdG9ybUBzaWVtZW5zLmNvbT4NCj4g
Pj4+IFN1YmplY3Q6IFJlOiBbaXNhci1jaXAtY29yZSAyLzJdIHJlcHJvZHVjaWJsZS55bWw6IERp
c2FibGUgc2lnbmVkDQo+ID4+PiBzd3VwZGF0ZSBpbiByZXByb2R1Y2libGUgdGVzdHMNCj4gPj4+
DQo+ID4+PiBPbiAwNi4xMC4yMyAxNDo1OCwgdmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20g
d3JvdGU6DQo+ID4+Pj4gRnJvbTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10
c2lwLmNvbT4NCj4gPj4+Pg0KPiA+Pj4+IHNpZ25lZCBhcnRpZmFjdHMgYXJlIG5vdCByZXByb2R1
Y2libGUgZHVlIHRvIGZhY3QgdGhhdCB0aGUNCj4gPj4+PiBzaWduYXR1cmUgY2FuIGluY2x1ZGUg
c29tZSByYW5kb21uZXNzIGZvciBzZWN1cml0eSByZWFzb25zLCBzbyBza2lwDQo+ID4+Pj4gc2ln
bmF0dXJlIHZlcmlmaWNhdGlvbnMgaW4gcmVwcm9kdWNpYmxlIHRlc3RzLg0KPiA+Pj4+DQo+ID4+
Pj4gRml4ZXMgIzgwDQo+ID4+Pj4NCj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiB2ZW5rYXRhIHB5bGEg
PHZlbmthdGEucHlsYUB0b3NoaWJhLXRzaXAuY29tPg0KPiA+Pj4+IC0tLQ0KPiA+Pj4+ICBrYXMv
b3B0L3JlcHJvZHVjaWJsZS55bWwgfCAxICsNCj4gPj4+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspDQo+ID4+Pj4NCj4gPj4+PiBkaWZmIC0tZ2l0IGEva2FzL29wdC9yZXByb2R1Y2li
bGUueW1sIGIva2FzL29wdC9yZXByb2R1Y2libGUueW1sDQo+ID4+Pj4gaW5kZXgNCj4gPj4+PiA1
ZDZhODk2Li43M2RkNGQ1IDEwMDY0NA0KPiA+Pj4+IC0tLSBhL2thcy9vcHQvcmVwcm9kdWNpYmxl
LnltbA0KPiA+Pj4+ICsrKyBiL2thcy9vcHQvcmVwcm9kdWNpYmxlLnltbA0KPiA+Pj4+IEBAIC0x
NSwzICsxNSw0IEBAIGxvY2FsX2NvbmZfaGVhZGVyOg0KPiA+Pj4+ICAgIHJlcHJvZHVjaWJsZS1i
dWlsZHM6IHwNCj4gPj4+PiAgICAgIFNPVVJDRV9EQVRFX0VQT0NIIDo9ICIke0BiYi5wcm9jZXNz
LnJ1bigiZ2l0IC1DDQo+ID4+Pj4gJHtMQVlFUkRJUl9jaXAtY29yZX0NCj4gPj4+IGxvZyAtMSAt
LXByZXR0eT0lY3QgfCB0ciAtZCAnXG4nIilbMF19Ig0KPiA+Pj4+ICAgICAgV0lDX0RFUExPWV9Q
QVJUSVRJT05TID0gIjEiDQo+ID4+Pj4gKyAgICBTV1VfU0lHTkVEID0gIjAiDQo+ID4+Pg0KPiA+
Pj4gU2hvdWxkbid0IHdlIHJhdGhlciBvciBhbHNvIGNoZWNrIGlmIGV2ZXJ5dGhpbmcgZXhjZXB0
IGZvciB0aGUgLnNpZw0KPiA+Pj4gZWxlbWVudCBpbiBhIHNpZ25lZCBTV1UgaXMgaWRlbnRpY2Fs
Pw0KPiA+Pg0KPiA+PiBJZiB3ZSBoYXZlIHRvIHNraXAgdGhlICJzdy1kZXNjcmlwdGlvbi5zaWci
IGZpbGUgdGhlbiBpdCB3aWxsIGFsc28NCj4gPj4gc2tpcCBzdy1kZXNjcmlwdGlvbiBmaWxlIGZy
b20gcmVwcm9kdWNpYmxlIHZlcmlmaWNhdGlvbi4NCj4gPj4NCj4gPj4gSWYgSSB1bmRlcnN0YW5k
IGNvcnJlY3RseSwgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiBzaWduZWQgYW5kIHVuc2lnbmVkDQo+
ID4+IHN3dXBkYXRlIGlzIHRoZSBzdy1kaXNjcmlwdGlvbiBmaWxlIGFuZCBpdCB3aWxsIGJlIHNp
Z25lZCBpbiBjYXNlIG9mDQo+ID4+IFNXVV9TSUdORUQ9IjEiLCBvdGhlcndpc2UgaXQgaXMgdW5z
aWduZWQgZmlsZS4NCj4gPj4gU28sIGlmIHdlIGRpc2FibGUgU1dVX1NJR05FRCB0aGF0IHdpbGwg
ZGlzY2FyZCB0aGUgc2lnbmF0dXJlLg0KPiA+Pg0KPiA+DQo+ID4gKFNvcnJ5IHRvIGp1bXAgaW4p
DQo+ID4gQW55IGNvbW1lbnRzIG9uIHRoaXMgYXBwcm9hY2ggKGRpc2FibGluZyBzaWduZWQgc3d1
cGRhdGUpPw0KPiA+DQo+IA0KPiBJIHdvdWxkIHN1Z2dlc3QgdG8gZGlzY3VzcyB3aXRoIHRoZSBk
aWZmb3Njb3BlIHBlb3BsZSBpZiB0aGVyZSBpcyBhIHdheSB0bw0KPiBjb25maWd1cmUgdGhlIHRv
b2wgZm9yIHRoaXMgc2NlbmFyaW8uIEknbSBzdGlsbCBjb25jZXJuIHRoYXQgd2UgYXJlIG5vdCB0
ZXN0aW5nIHRoZQ0KPiByaWdodCB0aGluZyB3aGVuIHdlIGRpc2FibGUgc2lnbmluZy4NCj4gDQo+
IEJUVywgdGhlIHNhbWUgYXBwbGllcyB0byBvdGhlciBzaWduZWQgYXJ0aWZhY3RzOiBJdCBzaG91
bGQgYmUgcG9zc2libGUgdG8NCj4gdmFsaWRhdGUgdGhhdCB5b3UgY2FuIHJlYnVpbGQgdGhpbmdz
IGJpdC1pZGVudGljYWxseSwganVzdCBtaW51cyBhbnkgaW5jbHVkZWQNCj4gY2VydGlmaWNhdGUg
b3IgaGFzaCBvciB5b3UtbmFtZS1pdC4gV2UgY3VycmVudGx5IGV4cGxvaXQgdGhhdCB3ZSB1c2Ug
YSBkZW1vDQo+IGtleSwgdGh1cyBoYXZlIGFjY2VzcyB0byBpdHMgcHJpdmF0ZSBwYXJ0LiBCdXQg
dGhhdCBzaG91bGQgbm90IGJlIGEgcHJlY29uZGl0aW9uDQo+IHRvIGNoZWNrIHJlcHJvZHVjaWJp
bGl0eS4NCg0KSSBpbnZlc3RpZ2F0ZWQgbGl0dGxlIG1vcmUgYW5kIGZvdW5kIHRoYXQgdGhlIHNp
Z25hdHVyZXMgb2YgdGhlIHN3dXBkYXRlIGZpbGUgaXMgbm90IGRldGVybWluaXN0aWNhbGx5IGNy
ZWF0ZWQgYmVjYXVzZSBpbiAiY21zIiBtZXRob2QgaXQgYWRkcyBzaWduaW5nIHRpbWUgaW4gdGhl
IGF0dHJpYnV0ZXMgc2VjdGlvbiBvZiB0aGUgc2lnbmF0dXJlIGRhdGEsDQpUaGlzIGNhbiBiZSBh
dm9pZGVkIGJ5IHBhc3NpbmcgIi1ub2F0dHIiIHRvIHRoZSBvcGVuc3NsLWNtcyBjb21tYW5kLCB0
aGVuIGl0IGNyZWF0ZXMgdGhlIHNpZ25hdHVyZXMgZGV0ZXJtaW5pc3RpY2FsbHkuDQoNCkFsc28s
IHdoZW4gc2lnbmluZyBtZXRob2QgaXMgdXNlZCBhcyAicnNhIiB0aGVuIGFsc28gdGhlIHNpZ25l
ZCBzd3VwZGF0ZSBmaWxlcyBhcmUgcmVwcm9kdWNpYmxlLg0KDQpJIHdpbGwgcmVzZW5kIHRoZSBw
YXRjaCB3aXRoICItbm9hdHRyIiBvcHRpb24gdXNlZCBpbiBvcGVuc3NsLWNtcyBjb21tYW5kLg0K
DQo+IA0KPiBKYW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj4gTGludXgg
RXhwZXJ0IENlbnRlcg0K


