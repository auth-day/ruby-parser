module Parser_nmap_function
  #scan table
  def insert_into_scan_table obj
    $startTime  = (obj.scanner.start_time).to_i   #PRIMARY KEY time start
    $parametres = obj.scanner.arguments           #arg parametres before launch

    obj.each_run_stat do |obj1|                      # Parses the essential runstats information.
    $endTime       = obj1.end_time                 #ending time
    $exitStatus    = obj1.exit_status              #up\down
    $elapsedTime   = obj1.elapsed                  #elapsed Time
    end
    $db.execute "insert into SCAN values('#{$startTime}','#{$parametres}','#{$endTime}',
    '#{$exitStatus}','NoHostSummYet','#{$elapsedTime}')"
  end

  #hosts table
  def insert_into_hosts_table obj
    $statusOfHosts    = obj.status.state.to_s     #status of the host
    $portsSumm        = obj.ports.size            #amount of ports of the host
    $ipAddressOfHost  = obj.ip                    #ip address of the host
    $macAddressOfHost = obj.mac                   #mac address of the host
    $timeEnd          = obj.end_time              #end of scan time
    $db.execute "insert into HOSTS values(#{$startTime},'#{$timeEnd}',?,'#{$statusOfHosts}',
    '#{$portsSumm}','#{$ipAddressOfHost}','noHostNameYet','#{$macAddressOfHost}',0)"
  end
  #ports table
  def insert_into_ports_table obj
      obj.each do |obj1|                             #getting information about ports state
      $db.execute "insert into PORTS values(?,'#{$ipAddressOfHost}','#{$startTime}','#{obj1.number}',
      '#{obj1.protocol}','#{obj1.state}','#{obj1.service.version}','#{obj1.service}')"
      end
  end

  #os table
  def insert_into_os_table obj
    obj.os.each_class do |obj1|
    $osType = obj1.type                            #os type
    $vendor = obj1.vendor                          #os vendor
    $gen    = obj1.gen                             #os generation
    $db.execute "insert into OS values(?,'#{$osType}','#{$vendor}','#{$gen}')"
    end
  end
end
