import processing.pdf.*;
import java.awt.geom.Line2D;

void setup() {
  size(800, 800);
  noLoop();
}

int nodes = 100;
boolean add_new_vector;

class Coords {
  public int x, y;
  Coords(int x, int y) {
    this.x = x;
    this.y = y;
  } 
}

class Vector {
  public Coords A, B;
  Vector(Coords A, Coords B) {
    this.A = A;
    this.B = B;
  }
}

Coords[] coordinates = new Coords[nodes];
ArrayList<Vector> vectors = new ArrayList<Vector>();
  
void draw() {
  for (int nodes_count=0; nodes_count<nodes; nodes_count++) {
    coordinates[nodes_count] = new Coords(int(randomGaussian()*100 + 400), int(randomGaussian()*100 + 400));

    if (nodes_count>0) {
      for (int inner_count = 0; inner_count <= nodes_count; inner_count++) {
        if (nodes_count != inner_count) {
          Vector new_vector = new Vector(coordinates[nodes_count], coordinates[inner_count]);
          if (! vectors.isEmpty()) {
            add_new_vector = true;
            for (int i = 0; i < vectors.size(); i++) {
              if ( !(
                     ((vectors.get(i).A.x == new_vector.A.x) && (vectors.get(i).A.y == new_vector.A.y)) 
                  || ((vectors.get(i).B.x == new_vector.B.x) && (vectors.get(i).B.y == new_vector.B.y)) 
                  || ((vectors.get(i).A.x == new_vector.B.x) && (vectors.get(i).A.y == new_vector.B.y)) 
                  || ((vectors.get(i).B.x == new_vector.A.x) && (vectors.get(i).B.y == new_vector.A.y))
                    ) && 
                  Line2D.linesIntersect(
                  vectors.get(i).A.x, vectors.get(i).A.y, vectors.get(i).B.x, vectors.get(i).B.y, 
                  new_vector.A.x, new_vector.A.y, new_vector.B.x, new_vector.B.y)
                  ) {
                add_new_vector = false;
                break;
              }
            }
            if (add_new_vector) {
              if (!vectors.contains(new_vector)) {
                vectors.add(new_vector);
                line(
                  new_vector.A.x, 
                  new_vector.A.y, 
                  new_vector.B.x, 
                  new_vector.B.y
                );
              }
            }
          } else {
            vectors.add(new_vector);
          }
        }
      }
    }
  }
  
}

