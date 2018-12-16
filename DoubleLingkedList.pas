program DoubleLingkedList;
uses crt;
type
    PData=^TData;
    TData=record
                prev:PData;
                info:integer;
                next:PData;
          end;

var
   Dawal,Dakhir:PData;
   Sawal,Sakhir:PData;
   Qawal,Qakhir:PData;

procedure buat_list(var awal,akhir:PData);
begin
     awal:=nil;
     akhir:=nil;
end;

procedure sisip_depan(data:integer;var awal,akhir:PData);
var
   baru:PData;
begin
     new(baru);
     baru^.info:=data;
     baru^.next:=nil;
     baru^.prev:=nil;
     if awal=nil then
     begin
          awal:=baru;
          akhir:=baru;
     end
     else
     begin
          baru^.next:=awal;
          awal^.prev:=baru;
          awal:=baru;
     end;
end;

procedure sisip_belakang(data:integer;var awal,akhir:PData);
var
   baru:PData;
begin
     new(baru);
     baru^.info:=data;
     baru^.next:=nil;
     baru^.prev:=nil;
     if awal=nil then
     begin
          awal:=baru;
          akhir:=baru;
     end
     else
     begin
          akhir^.next:=baru;
          baru^.prev:=akhir;
          akhir:=baru;
     end;
end;

procedure sisip_tengah(data:integer;var awal,akhir:PData);
var
   baru:PData;
   dicari:integer;
   bantu:PData;
begin
     if awal=nil then
     begin
          sisip_depan(data,awal,akhir);
     end
     else
     begin
          write('Posisi sisip setelah data berapa ? ');readln(dicari);
          bantu:=awal;
          while (bantu^.info<>dicari)and(bantu<>akhir) do
                bantu:=bantu^.next;

          if bantu^.info=dicari then
          begin
               new(baru);
               baru^.info:=data;
               baru^.next:=nil;
               baru^.prev:=nil;

               baru^.prev:=bantu;
               baru^.next:=bantu^.next;
               bantu^.next^.prev:=baru;
               bantu^.next:=baru;
               writeln('beres');
          end
          else
              writeln('Posisi sisip tidak ditemukan. Penyisipan dibatalkan');

    end;
end;

procedure hapus_depan(var data:Integer;var awal,akhir:PData);
var
   bantu:PData;
begin
     if awal=nil then
        writeln('Data kosong!')
     else
     if awal=akhir then
     begin
          data:=awal^.info;
          dispose(awal);
          awal:=nil;
          akhir:=nil;
     end
     else
     begin
          data:=awal^.info;
          bantu:=awal;
          awal:=awal^.next;
          dispose(bantu);
          awal^.prev:=nil;
     end;
end;
procedure hapus_belakang(var data:Integer;var awal,akhir:PData);
var
   bantu:PData;
begin
     if awal=nil then
        writeln('Data kosong!')
     else
     if awal=akhir then
     begin
          hapus_depan(data,awal,akhir);
     end
     else
     begin
          data:=akhir^.info;
          bantu:=akhir^.prev;
          dispose(akhir);
          akhir:=bantu;
          akhir^.next:=nil;
     end;
end;

procedure hapus_tengah(var data:Integer;var awal,akhir:PData);
var
   bantu,bantu2:PData;
   posisi:integer;
   posisihapus:integer;
begin
     if awal=nil then
        writeln('Data Kosong')
     else
     if awal=akhir then
     begin
          hapus_depan(data,awal,akhir);
     end
     else
     begin
          write('Posisi hapus data dalam doubled linked list ke-?');readln(posisihapus);
          bantu:=awal;
          posisi:=1;
          while posisi < posisihapus-1 do
          begin
               bantu:=bantu^.next;
               posisi:=posisi+1;
          end;
          bantu2:=bantu^.next;
          if(bantu^.next = akhir) then
          begin
               hapus_belakang(data,awal, akhir);
          end
          else if (bantu = awal) then
          begin
               hapus_depan(data,awal, akhir);
          end
          else 
          begin
               bantu^.next:=bantu2^.next;
               bantu2^.next^.prev:=bantu;
               data:=bantu2^.info;
               dispose(bantu2);
          end;
     end;
end;

procedure tampil_data(awal:PData);
var
   bantu:PData;
begin
     writeln('Data  : ');
     bantu:=awal;
     while bantu<>nil do
     begin
          write(bantu^.info:6);
          bantu:=bantu^.next;
     end;
     writeln;
end;

{ function isEmpty(awal:PData) : boolean;
begin
     if (awal = nil) then
          isEmpty := true
     else 
          isEmpty := false;
end;

function isOneNode(awal:PData) : boolean;
begin
     if (awal^.next = nil) then
          isOneNode := true
     else
          isOneNode := false;
end; }

procedure push(data:integer;var Sawal:PData);
var
   baru:PData;
begin
     new(baru);
     baru^.info:=data;
     baru^.next:=nil;
     baru^.prev:=nil;
     if Sawal=nil then
     begin
          Sawal:=baru;
     end
     else
     begin
          baru^.next:=Sawal;
          Sawal^.prev:=baru;
          Sawal:=baru;
     end;
end;


procedure pop(var Sawal:PData);
var
   bantu:PData;
begin
     if Sawal=nil then
        writeln('Data kosong!')
     else
     begin
          writeln('Data dalam stack yang dihapus adalah ', Sawal^.info);
          bantu:=Sawal^.next;
          dispose(Sawal);
          Sawal:=bantu;
          Sawal^.prev := nil;
     end;
end;

procedure dequeue(var Qawal, Qakhir:PData);
var
   bantu:PData;
begin
     if Qawal=nil then
        writeln('Data kosong!')
     else
     begin
          writeln('Data dalam queue yang dihapus adalah ', Qawal^.info);
          bantu:=Qawal^.next;
          dispose(Qawal);
          Qawal:=bantu;
          Qawal^.prev := nil;
     end;
end;

var
   i, temp, pil:integer;
begin
     //bangun list
     buat_list(Dawal,Dakhir);
     buat_list(Sawal,Sakhir);
     buat_list(Qawal,Qakhir);

     for i:=1 to 10 do
     begin
          sisip_depan(random(100),Dawal,Dakhir);
          //stack
          push(random(100), Sawal);
          // WriteLn();
          // WriteLn('Menampilkan data Stack');
          // tampil_data(Sawal);
          //queue
          sisip_belakang(random(100), Qawal, Qakhir);
          // Writeln();
          // Writeln('Menampilkan data Queue');
          // tampil_data(Qawal);
     end;
     writeln('Menampilkan data Doubled Linked List');
     tampil_data(Dawal);

     WriteLn();
     WriteLn('Menampilkan data Stack');
     tampil_data(Sawal);

     Writeln();
     Writeln('Menampilkan data Queue');
     tampil_data(Qawal);

     repeat 
          writeln('1. sisip depan linked list');
          writeln('2. sisip tengah linked list');
          writeln('3. sisip akhir linked list');
          writeln('4. hapus depan linked list');
          writeln('5. hapus tengah linked list');
          writeln('6. hapus akhir linked list');
          writeln('7. push stack');
          writeln('8. pop stack');
          writeln('9. enqueue');
          writeln('10. dequeue');     
          WriteLn('0. exit');
          WriteLn();
          Write('Pilihan anda? ');
          readln(pil);

          case pil of 
          1 : 
               begin
                    Write('Masukkan nilai yang ingin dimasukkan : '); readln(temp);
                    sisip_depan(temp,Dawal,Dakhir);
                    writeln('Menampilkan data Doubled Linked List');
                    tampil_data(Dawal);     
               end;
          2 : 
               begin
                    Write('Masukkan nilai yang ingin dimasukkan : '); readln(temp);
                    sisip_tengah(temp,Dawal,Dakhir);
                    writeln('Menampilkan data Doubled Linked List');
                    tampil_data(Dawal);     
               end;
          3 : 
               begin
                    Write('Masukkan nilai yang ingin dimasukkan : '); readln(temp);
                    sisip_belakang(temp,Dawal,Dakhir);
                    writeln('Menampilkan data Doubled Linked List');
                    tampil_data(Dawal);     
               end;
          4 : 
               begin
                    hapus_depan(temp,Dawal,Dakhir);
                    writeln('Data yang dihapus adalah ',temp);
                    writeln('Menampilkan data Doubled Linked List');
                    tampil_data(Dawal);
               end;
          5 : 
               begin
                    hapus_tengah(temp,Dawal,Dakhir);
                    writeln('Data yang dihapus adalah ',temp);
                    writeln('Menampilkan data Doubled Linked List');
                    tampil_data(Dawal);
               end;
          6 : 
               begin
                    hapus_belakang(temp,Dawal,Dakhir);
                    writeln('Data yang dihapus adalah ',temp);
                    writeln('Menampilkan data Doubled Linked List');
                    tampil_data(Dawal);
               end;
          7 : 
               begin
                    Write('Masukkan nilai yang ingin dimasukkan : '); readln(temp);
                    push(temp,Sawal);
                    writeln('Menampilkan data Stack');
                    tampil_data(Sawal);
               end;
          8 : 
               begin
                    pop(Sawal);
                    writeln('Menampilkan data Stack');
                    tampil_data(Sawal);
               end;
          9 : 
               begin
                    Write('Masukkan nilai yang ingin dimasukkan : '); readln(temp);
                    sisip_belakang(temp,Qawal,Qakhir);
                    writeln('Menampilkan data Queue');
                    tampil_data(Qawal);     
               end;
          10 : 
               begin
                    dequeue(Qawal, Qakhir);
                    writeln('Menampilkan data Queue');
                    tampil_data(Qawal);     
               end;
          0:begin
            
          end;
          else WriteLn('Pilihan tidak tersedia');
          end;
     until pil = 0;
     WriteLn('program selesai');
end.
