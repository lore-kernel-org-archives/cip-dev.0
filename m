Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96147C433EF
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 11:14:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web08.82902.1657019685084845569
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jul 2022 04:14:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 265BEgFS016279;
 Tue, 5 Jul 2022 20:14:42 +0900
X-Iguazu-Qid: 34tKOOWMcQftkpR1H7
X-Iguazu-QSIG: v=2; s=0; t=1657019682; q=34tKOOWMcQftkpR1H7;
 m=KZRVWp3ioMNQczqm98SHU2MqBGvsIapjpz5tnIKC7xY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1511) id 265BEe65024367
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 5 Jul 2022 20:14:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rm1sVbeKjkX7zSHkscy566WaRJdzHzu2j59IDKGUImKf6I0crh2aYNj3OmCaZZdmdxxPd63n3jwRPDkdYpIjnhkIdTQ0X9HDLiarx3xowyZ2LT217fR5bhxU2iZsTva5IXRNFrgJfTaxgH8rIUu6jDM19s0LuA6fOq83jq/zkganeXY5LsLgwPdpCZIicN5gBWJV6KXP4oHrgDPf/m9GqeRR3dgxuxN7JrmovCkbwU4Rjafo1Lnif8liUzqL/m/WZh5OxiL906QR/B5NJZB9rBLdukOy8JVerJ0AcnGSFZfQPn58MOXjHoAC/3lmJkI1m8azzBn4+6MoW//LNpu/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwsgoBmbIHVLn/PiUJcWAAyoLzperqAh8/6SK1nBNfQ=;
 b=fxim2ItP+KtUxPE4mONEwNkYBobGs4G3u+cFNsLMq3ZKQ0VUbUh5UVZ3hcd+8DTdPalPEwvaF2JJILtJB/RJQO1eZlmf6wNW0RupDsK3xm2vGUPhJ7IMY3W30xexmA4178vCgPRvATsvdb4BSqHguxI3VGXQZuFNlX9T42C+F5wHx1rKjSkTybRhcDYmgS0ozqGVYZ5dk7lLbgWO1fzL09aJRQP1sep2PdRzzrCfm517yRZWcYle3YI7rvGeMX69huXCvO+rE7mHddZ5R2bO7g1u6ZLbiOUq9D21x4VCbo8jjPvZw/P2jzKCDWCi52+u6vKsO47DTL6FagPl74RVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core][PATCH] security-testing.yml: Add kas option for
 IEC layer testing
Thread-Topic: [isar-cip-core][PATCH] security-testing.yml: Add kas option for
 IEC layer testing
Thread-Index: AQHYkEzLsOD/DOZCs0ShWZlzAqK7r61vmjaw
Date: Tue, 5 Jul 2022 11:14:38 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB5542CC30289B807E5A66A5AAA4819@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20220704172122.11322-1-venkata.pyla@toshiba-tsip.com>
 <b8271bd9-8574-4bc7-9c96-5dc8843d22f0@siemens.com>
In-Reply-To: <b8271bd9-8574-4bc7-9c96-5dc8843d22f0@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2871ae9b-7e68-4e74-d2b5-08da5e778cd2
x-ms-traffictypediagnostic: OSAPR01MB1585:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 KX0C0WChD5Qa/F67Bt3MscLwnmgjdGauSbFWLzW8j603bocb4JaCCwZsUtUHuovnMvUYdSy1pf3IKkzxoE0VryQmla0LeAm7Jh6yY2JMZbFPB+KbnzYZVZOEcurTEF2ytyMGmEpSMZBx8e955VW577zcUbgcttvdsfpsLzNvne6Yu7NFApGUo70LmN1UFEmOqubDHzBMOVZxMTno5MTtNNQPAqP8ssdS5Kb3tCEXNMaQe4iP02Fe7k6GV1QOboPqMQHGDM1dnKbbagWnkLWaHAfQe71UzIr/383qJylIGuP47xOo9yJw6Lqw4y+1v79D7QWTIjl3j8Q/74qpTKjcrQTPpBzCEakRY+C2uWPNawrVvR5paS3a8/9l2c3+hDwudDhuSjPMHcr5bRsT2KbVizp14ZuNjRNn6WRM/PRa3jTJQjBtLzbDgR7gjOgBFf47KeOSY1ervubBkLiw3hYz+23vmtjAhzmoqG3DNGBMQVrTHz2GzkytussHN+TI/zWjvAiFNLotWnOJmcoQpopegoJUy+YKvQwdeOAdTQizH8Vxd+TzFcVErmab814VbhXhkEAGY7iCgHImgGdr6KXi8VG3aFX8WQ0xw09xE/odoscO7ys/mZ+1veUc8UVJTVolj35AhUYCX0wFWEvvr7JCUqwFIHAcHTmXT8Exvo1IAJ9RXnOJT9nsQ67k2aBaUO8FET76p9eJUOnK0aL4pCEW5/6OiYogqvcB/xSyKzmq1jvvd9EGl6N1lQyn8wkO9y3ttW0S9mpUZxeA1r8G1+kTVm5PkiWdz/EEYvgHDx2hPJ3V1yLUWMZOpSFNuc250vYIOUyxIN0e1TJ1tkp7yR83iJ/aqmq2YdYwaist96MYlew=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(5660300002)(86362001)(52536014)(15650500001)(38100700002)(8936002)(107886003)(186003)(122000001)(83380400001)(85182001)(33656002)(38070700005)(6506007)(9686003)(966005)(478600001)(54906003)(316002)(110136005)(26005)(41300700001)(66946007)(66556008)(64756008)(66446008)(76116006)(2906002)(66476007)(8676002)(71200400001)(55016003)(4326008)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bThCdUVoaUhQTjVwby9MWWJuclp3c3I5YnlvTndPb3ZydWZNZE9tOFRsTDlD?=
 =?utf-8?B?QVk5dXhDNUx6ckpMM1FLbGRuK202Rk8wWE9qQUlyYThVL0dUKzV2TGFJS1k3?=
 =?utf-8?B?cFdBTHpZWmZaVS9WVEwySUxUMmI4b3lyaFJHdmhBTUJYaWtTbjZzejYvcjhF?=
 =?utf-8?B?R1k4UkZwVS8zNWNqTnIvLzZ3YnFYMSszVElkVzB5aUhtVWFkMUNsZnlZYytr?=
 =?utf-8?B?bHlnZ0luT05xZEIvT1ljMTdvNXczeU9jYVpZeWxwTWtkRXE1SDJURXh5RmZv?=
 =?utf-8?B?ZVNmV3JMZzBjS1pvSC96Z3pSV0hGVGxiblVYYjdvbFczQmd3S0ZrbThGYkVx?=
 =?utf-8?B?NlliVHowYlJjYmJtOTJSc1B5U3A2enBjcjU3cWxIbjdKcWdNRG9Yc2tqWWg5?=
 =?utf-8?B?SWhpZ2taWWhYZTd1NmF2QzVwN3dtdFlxQVYxdjZIaWdVMzBhWldTTFo0bml2?=
 =?utf-8?B?T0pkQjdtTjM3ejJDNTBGK2hzeTZ2bnZ4amFNTEttMDRvYjRlaG8xZGlOSkFy?=
 =?utf-8?B?bUJWRklqM0FMcUpOUVF5ZEdkY0g5azMwWXlxeEZxejJSY0dmTTZnVlJIMmFn?=
 =?utf-8?B?aTNMTWsyS1BJLzhOTEVjMi9uNENucjVpRzV2SW05MytCRHIwZittTk9hd1Fr?=
 =?utf-8?B?dDRnT0k0OEpNNlpWUFJ6OWJLVmJ0cWxCUmdtaVE4djdtenZHTXRFbVZpSlJm?=
 =?utf-8?B?UW4xOW1EeUljdk1uVFFNeW0vcThnYmQ5SXU1SzlPOTNPNzVnUEIxOVZNVnpS?=
 =?utf-8?B?c3JROGh5RlZnSGxkNjd2R2dRVm5rdDVHbnlpK0ZLNmdvblJMZStvN1RQcGRk?=
 =?utf-8?B?dW1JUnZMWHBoK1p5dW9OajJBdXduTmcrYXV6TS9jdlM3SXZ6ZVFGUFRkeEd6?=
 =?utf-8?B?Y1RqTDUzU2gyL3hJVkh1bDFta1l5d2EwL2F0L21mQkR0aDEvaVdJRnNjdFdR?=
 =?utf-8?B?MURjaC9zQS95VmU3Y0ZaS3FOZ3RjemljYXhzZ2dCS3BRQmZiWlFnelFJR0FE?=
 =?utf-8?B?cko3MC9admY5TTIwU0JXRVVaelhtSDdsVktOM0o2UEJ1UjJsUmZWMG9KUW1i?=
 =?utf-8?B?aDdvckRSOWcvUXo2cDZGdDRFQm40RjBVU3NQUjdDS2JSVE1XUUpmSmhMN0FP?=
 =?utf-8?B?MUNDNC9sUGFKNGhiaTd1akY4RFBVaWJjekFMK3AzMjM0YWxZdWhiTk9wM1l4?=
 =?utf-8?B?Mk9TQUxzekZXU0xJOEt5OU0rdE8xY01QMTU5dUVTNHQ5NVVwOUx0NEpVUm94?=
 =?utf-8?B?L2FmdHlHb1hLS1A2dEd3ZzEzeCtMcm1DVEk2S0tzVU80bW9aY2ZIcG5OSi92?=
 =?utf-8?B?VTVoVk84aU5GYm43TWY3M3h4WUNNbHFKeDJTUEJuVHNsLzBKNjZ4bW9zVkZ4?=
 =?utf-8?B?bmdxOGxZdS9XWEdsOTNsVkFVbDJ2TE5nb3I1MW5nUWtvMlo2VjJGWWNMOXBQ?=
 =?utf-8?B?L0lVaGJmN2ZEQjNORERCd3J3Y2cxcFZLK2RiOVhlZ0d5d0lMbW5TdGJnSGdF?=
 =?utf-8?B?TUpuY2I0Nm9hSkwvM1ZkZC9QUFREMkVQVGU0Z1MzcHBaYXBYRjVnSmlLdXVr?=
 =?utf-8?B?dWZxTkNIdk5Oek4wMElYVnkxMXdZUG5TV2RnakRJanEra1F4S1V3MUppTy9s?=
 =?utf-8?B?ZXFqeHlkMkRzOW5qM1FOOXRlRWFGNmtBOUVMbnA4OFc2MGFYdEIrcUVsM1Jm?=
 =?utf-8?B?eUlWdEtTZWRIa0YvOURiQ2lFVEhxT3R6MWlGV3M3emNWWlNHelkreTFpNDAz?=
 =?utf-8?B?aFV3a3prWGM5WWhyRDNsTGFnTUJNcnBhWGNPK1ZxdXVEY056MXFoZU9GVElx?=
 =?utf-8?B?RTFoODBab1hRaCtiT0tNcWViUWJrRVZmS3dIZjBnVXE2eHExV2NsWm1pYnZi?=
 =?utf-8?B?SDI4ZHI5aTlUUkNtUktJNnJhT2pLcXo4Rm1ZRkNBT3dldlN2dXJNbmg4c1FF?=
 =?utf-8?B?RjNIL2k0QVhTVHg0MlNzTjJpZnBpOThEVmJlNzlPOUtJU1h0bjM3YjRtQ1By?=
 =?utf-8?B?dnNDVWhDbUQxMXZ3cG11UHlLSitqWUh5NUZscERwOHI5ekNQcEIyRS82TU5T?=
 =?utf-8?B?TzR6VW1vU3BvUnh2cUJ6RHRjb2ZYbmVsUHQrYzEyUEV3SnBDREN2NThUQ2oz?=
 =?utf-8?B?ZmRJSFhMd0poazN6SmlkeXNzeWxJYndqL0ViUlFMQ2xBa1grSGNabVBnbFpJ?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2871ae9b-7e68-4e74-d2b5-08da5e778cd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 11:14:38.2936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Nt537rB905Os+UEheQOTLsO4vuoYsAqWi/VtKkq5Hhij3T2hBazO/q0MC0gr02U3ML5n77dascu6swnK3VWYpJ3Ez5XwfZDfCzGDAJ55gEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1585
X-OriginatorOrg: toshiba-tsip.com
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 11:14:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8683

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogMDUgSnVseSAyMDIyIDE0OjI0DQo+VG86IHB5bGEg
dmVua2F0YSjvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxWZW5rYXRhLlB5bGFAdG9z
aGliYS0NCj50c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+Q2M6IGRp
bmVzaCBrdW1hcijvvLTvvLPvvKnvvLApIDxkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT47
IGhheWFzaGkNCj5rYXp1aGlybyjmnpcg5ZKM5a6PIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkg
PGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQo+U3ViamVjdDogUmU6IFtpc2FyLWNp
cC1jb3JlXVtQQVRDSF0gc2VjdXJpdHktdGVzdGluZy55bWw6IEFkZCBrYXMgb3B0aW9uIGZvciBJ
RUMNCj5sYXllciB0ZXN0aW5nDQo+DQo+T24gMDQuMDcuMjIgMTk6MjEsIHZlbmthdGEucHlsYUB0
b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0KPj4gRnJvbTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5
bGFAdG9zaGliYS10c2lwLmNvbT4NCj4+DQo+PiBUaGlzIGthcyBvcHRpb24gZmlsZSBhZGRzIGFk
ZGl0b25hbCBwYWNrYWdlcyByZXF1aXJlZCBvbmx5IHdoaWxlDQo+PiB0ZXN0aW5nIHVzaW5nIGNp
cC1zZWN1cml0eS10ZXN0c1sxXS4NCj4+DQo+PiBBbHNvIGl0IHByb3ZpZGVzIGFkZGl0aW9uYWwg
cm9vdGZzIHNpemUgcmVxdWlyZWQgZm9yIHRlc3RpbmcuDQo+Pg0KPj4gWzFdIGh0dHBzOi8vZ2l0
bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtdGVzdGluZy9jaXAtc2VjdXJpdHktdGVzdHMNCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiB2ZW5rYXRhIHB5bGEgPHZlbmthdGEucHlsYUB0b3NoaWJhLXRzaXAu
Y29tPg0KPj4gLS0tDQo+PiAga2FzL29wdC9zZWN1cml0eS10ZXN0aW5nLnltbCB8IDIwICsrKysr
KysrKysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4+
ICBjcmVhdGUgbW9kZSAxMDA2NDQga2FzL29wdC9zZWN1cml0eS10ZXN0aW5nLnltbA0KPj4NCj4+
IGRpZmYgLS1naXQgYS9rYXMvb3B0L3NlY3VyaXR5LXRlc3RpbmcueW1sDQo+PiBiL2thcy9vcHQv
c2VjdXJpdHktdGVzdGluZy55bWwgbmV3IGZpbGUgbW9kZSAxMDA2NDQgaW5kZXgNCj4+IDAwMDAw
MDAuLjE5MjE1ZjENCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2thcy9vcHQvc2VjdXJpdHkt
dGVzdGluZy55bWwNCj4+IEBAIC0wLDAgKzEsMjAgQEANCj4+ICsjDQo+PiArIyBDSVAgQ29yZSwg
Z2VuZXJpYyBwcm9maWxlDQo+PiArIw0KPj4gKyMgQ29weXJpZ2h0IChjKSBUb3NoaWJhIENvcnBv
cmF0aW9uLCAyMDIyICMgIyBBdXRob3JzOg0KPj4gKyMgIFZlbmthdGEgUHlsYSA8dmVua2F0YS5w
eWxhQHRvc2hpYmEtdHNpcC5jb20+ICMgIw0KPj4gK1NQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBN
SVQgIw0KPj4gK2hlYWRlcjoNCj4+ICsgIHZlcnNpb246IDEwDQo+PiArICBpbmNsdWRlczoNCj4+
ICsgICAtIGthcy9vcHQvc2VjdXJpdHkueW1sDQo+PiArDQo+PiArbG9jYWxfY29uZl9oZWFkZXI6
DQo+PiArICAgICBzZWN1cml0eV90ZXN0aW5nOiB8DQo+PiArICAgICAgICBJTUFHRV9QUkVJTlNU
QUxMX2FwcGVuZCA9ICIgc3NocGFzcyINCj4+ICsgICAgICAgIFJPT1RGU19FWFRSQSA9ICI4MTky
Ig0KPj4gKw0KPg0KPlRoZXJlIGlzIGFscmVhZHkga2FzL29wdC90ZXN0LnltbC4gQ2FuJ3Qgd2Ug
cGlnZ3ktYmFjayBvbiB0aGF0IG9uZT8NCj5Xb3VsZCBhbHNvIGFscmVhZHkgY29tZSB3aXRoIGtj
b25maWcgc3VwcG9ydC4NCg0KWWVzIEkgdGhpbiBzbywgd2UgY2FuIGFsc28gYWRkIHNlY3VyaXR5
IHRlc3RpbmcgcmVxdWlyZW1lbnRzIGluIHRvIHRlc3QueW1sLCANCmJ1dCBkb2VzIGl0IG5vdCBj
cmVhdGUgYW55IHNpZGUgZWZmZWN0IHRvICB0aGUgb3JpZ2luYWwgdGVzdCBpbWFnZT8NCnNlY3Vy
aXR5IHRlc3RpbmcgcmVxdWlyZW1lbnRzIGFkZHMgYWRkaXRpb25hbCBwYWNrYWdlIGBzc2hwYXNz
YCBhbmQgaW5jcmVhc2VzIA0KdGhlIHJvb3RmcyBzaXplLg0KDQpPciwgY2FuIHdlIHNlbGVjdCB0
aGUgbG9jYWxfY29uZl9oZWFkZXIgZnJhZ21lbnQgKCd0ZXN0aW5nJyBvciAnc2VjdXJpdHlfdGVz
dGluZycpDQogZnJvbSB0aGUga2NvbmZpZyBiYXNlZCBvbiBpbWFnZSBpcyBzZWxlY3RlZD8gDQoN
Cj4NCj5KYW4NCj4NCj4tLQ0KPlNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj5Db21wZXRlbmNlIENl
bnRlciBFbWJlZGRlZCBMaW51eA0K


