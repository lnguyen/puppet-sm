class sm::packages {

  $sm::exts.each { |$ext| 
    exec { "installing ext ${ext}":
      command => "sm set install ${set}",
      path => "/opt/sm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
    }
  }

  $sm::sets.each { |$set, $packages|
    exec { "installing set ${set}":
      command => "sm set install ${set}",
      path => "/opt/sm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
    }
    $packages.each { |$package, $commands|
      $commands.each { |$index, $command|
        $next_command = $commands[$index+1]
        if $index < size($commands)-1 {
          exec { "install ${package} with command ${command}":
            command => "sm ${package} ${command}",
            path => "/opt/sm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
            require => Exec["installing set ${set}"],
            before => Exec["install ${package} with command ${next_command}"]
          } 
        } else {
          exec { "install ${package} with ${command}":
            command => "sm ${package} ${command}",
            path => "/opt/sm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
            require => Exec["installing set ${set}"],
          } 
        }
      }
    }
  }
}
