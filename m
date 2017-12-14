From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 14 Dec 2017 14:57:13 +0900
Subject: [cip-dev] [PATCH 1/3] Vagrantfile: support the http proxy plugin
In-Reply-To: <1513231035-42479-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
References: <1513231035-42479-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
Message-ID: <1513231035-42479-2-git-send-email-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

The proxy settings are collected from the environment.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 Vagrantfile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Vagrantfile b/Vagrantfile
index 2771600..1e1a491 100644
--- a/Vagrantfile
+++ b/Vagrantfile
@@ -23,6 +23,11 @@ SCRIPT
 Vagrant.configure(2) do |config|
   config.vm.provider :virtualbox do |vbox, override|
     config.vm.box = "debian/stretch64"
+    if Vagrant.has_plugin?("vagrant-proxyconf")
+      config.proxy.http     = ENV["http_proxy"]
+      config.proxy.https    = ENV["https_proxy"]
+      config.proxy.no_proxy = ENV["no_proxy"]
+    end
     
     vbox.customize ["modifyvm", :id, "--vram", "12"]
     vbox.customize ["modifyvm", :id, "--memory", "2048"]
-- 
2.7.4
